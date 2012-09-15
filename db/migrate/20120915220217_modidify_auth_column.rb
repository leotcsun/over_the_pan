class ModidifyAuthColumn < ActiveRecord::Migration
  def change
    change_column :authentications, :user_id, :bigint
  end
end
