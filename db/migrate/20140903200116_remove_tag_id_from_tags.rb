class RemoveTagIdFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :tag_id, :integer
  end
end
