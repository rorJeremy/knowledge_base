  # create_table "posts", force: true do |t|
  #   t.string   "title"
  #   t.text     "body"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.integer  "category_id"
  # end

require 'elasticsearch/model'

class Post < ActiveRecord::Base
  self.table_name = 'posts'
  self.primary_key = 'id'

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :posts_tags
  has_many :tags, through: :posts_tags, after_add: [ lambda { |a,c| a.__elasticsearch__.index_document } ], after_remove: [ lambda { |a,c| a.__elasticsearch__.index_document } ]

  belongs_to :category

  attr_accessor :title_tags

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
      indexes :body, analyzer: 'english'
      indexes :tag_list, type: :string, analyzer: 'snowball'
      indexes :category_name
    end
  end

  def tag_list
    tags && tag_names
  end

  def tag_names
    tag_names = []
    tags.each do |tag|
      tag_names << tag.name
    end
    tag_names
  end

  def category_name
    category && category.name
  end

  INDEXABLE_METHODS = %i(title body category_name tag_list)

  def as_indexed_json(options={})
    {}.tap do |json|
      INDEXABLE_METHODS.each { |method| json[method] = send method }
    end
  end

  # This is equivalent to the above
  # def as_indexed_json(options={})
  #   {
  #     title: title,
  #     body: body,
  #     category_name: category_name,
  #     tag_list: tag_list
  #   }
  # end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fuzziness: "AUTO",
            fields: ['tag_list^10', 'category_name^8', 'title^5', 'body']
          }
        },
        highlight: {
          fields: {
            title: {},
            body: {},
            category_name: {},
            tag_list: {}
          }
        }
      }
    )
  end

end

# Delete the previous posts index in Elasticsearch
Post.__elasticsearch__.client.indices.delete index: Post.index_name rescue nil

# Create the new index with the new mapping
Post.__elasticsearch__.client.indices.create \
  index: Post.index_name,
  body: { settings: Post.settings.to_hash, mappings: Post.mappings.to_hash }

# Index all Post records from the DB to Elasticsearch
Post.import # for auto sync model with elastic search