class AddCounterToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :counter, :integer ,default: 0
  end
end
