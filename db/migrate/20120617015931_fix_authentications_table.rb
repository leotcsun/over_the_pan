class FixAuthenticationsTable < ActiveRecord::Migration
  def change
    rename_column :authentications, :uid, :weibo_id
    add_column :authentications, :access_token, :string
  end
end
