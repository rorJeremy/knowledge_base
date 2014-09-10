  # create_table "categories", force: true do |t|
  #   t.string   "name"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

class Category < ActiveRecord::Base
  has_many :posts
end