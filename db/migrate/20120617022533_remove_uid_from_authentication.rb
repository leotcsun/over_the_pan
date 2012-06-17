class RemoveUidFromAuthentication < ActiveRecord::Migration
  def change
    remove_column :authentications, :uid
  end
end
