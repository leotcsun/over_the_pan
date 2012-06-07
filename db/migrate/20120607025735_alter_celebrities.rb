class AlterCelebrities < ActiveRecord::Migration
  def change
    rename_column :celebrities, :screen_name, :domain
  end
end
