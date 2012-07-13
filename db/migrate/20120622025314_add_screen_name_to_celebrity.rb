class AddScreenNameToCelebrity < ActiveRecord::Migration
  def change
    add_column :celebrities, :screen_name, :string
  end
end
