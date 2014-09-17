  # create_table "tags", force: true do |t|
  #   t.string   "name"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts
end