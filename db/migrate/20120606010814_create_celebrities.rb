class CreateCelebrities < ActiveRecord::Migration
  def change
    create_table :celebrities do |t|
      t.integer :uid, unique: true
      t.string :screen_name

      t.timestamps
    end

    add_index :celebrities, :uid
  end
end
