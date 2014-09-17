class AddTagIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tag_id, :integer
  end
end
