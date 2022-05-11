class AddNumberToMessage < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :number, :integer
  end
end
