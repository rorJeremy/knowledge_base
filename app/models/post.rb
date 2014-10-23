  # create_table "posts", force: true do |t|
  #   t.string   "title"
  #   t.text     "body"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.integer  "category_id"
  # end

require 'elasticsearch/model'

class Post < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :posts_tags
  has_many :tags, through: :posts_tags

  belongs_to :category

  attr_accessor :title_tags

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
      indexes :body, analyzer: 'english'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'body']
          }
        },
        highlight: {
          fields: {
            title: {},
            body: {}
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