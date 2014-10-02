  # create_table "tags", force: true do |t|
  #   t.string   "name"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

class Tag < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :posts_tags
  has_many :posts, through: :posts_tags
end