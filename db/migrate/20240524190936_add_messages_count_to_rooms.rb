class AddMessagesCountToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :messages_count, :integer, default: 0, null: false
  end
end
