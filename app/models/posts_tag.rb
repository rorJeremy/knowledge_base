  # create_table "posts", force: true do |t|
  #   t.string   "title"
  #   t.text     "body"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.integer  "category_id"
  # end

class PostsTag < ActiveRecord::Base

  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  validates :tag_id, uniqueness: {scope: :post_id, message: "Tag is already associated with this post!"}

  belongs_to :post
  belongs_to :tag

  accepts_nested_attributes_for :tag
end
