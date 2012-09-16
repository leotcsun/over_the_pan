class ChangeCelebrityUidType < ActiveRecord::Migration
  def up
    change_column :celebrities, :uid, :bigint
  end
end
