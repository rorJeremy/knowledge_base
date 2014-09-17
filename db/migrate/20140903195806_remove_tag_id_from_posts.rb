class RemoveTagIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :tag_id, :integer
  end
end
