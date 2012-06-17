class RenameAuthenticaitonWeiboId < ActiveRecord::Migration
  def change
    rename_column :authentications, :weibo_id, :uid
  end
end
