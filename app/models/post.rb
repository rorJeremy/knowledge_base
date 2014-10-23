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

end

Post.import # for auto sync model with elastic search