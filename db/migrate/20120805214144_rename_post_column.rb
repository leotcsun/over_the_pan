class RenamePostColumn < ActiveRecord::Migration
  def change
    rename_column :posts, :author, :celebrity_id
  end
end
