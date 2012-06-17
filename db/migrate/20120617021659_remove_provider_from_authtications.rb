class RemoveProviderFromAuthtications < ActiveRecord::Migration
  def change
    remove_column :authentications, :provider
  end
end
