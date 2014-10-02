  # create_table "posts", force: true do |t|
  #   t.string   "title"
  #   t.text     "body"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.integer  "category_id"
  # end

class Post < ActiveRecord::Base

  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  has_many :posts_tags
  has_many :tags, through: :posts_tags
  accepts_nested_attributes_for :posts_tags, allow_destroy: true

  belongs_to :category
end
