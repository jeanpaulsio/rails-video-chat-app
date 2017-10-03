class AddIndexToRoom < ActiveRecord::Migration[5.1]
  def change
    add_index :rooms, :name, unique: true
  end
end
