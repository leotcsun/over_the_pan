class ChangeUsersColumnType < ActiveRecord::Migration
  def up
    change_column :users, :uid, :bigint
  end
end
