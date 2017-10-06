class AddPasswordToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :password, :string
  end
end
