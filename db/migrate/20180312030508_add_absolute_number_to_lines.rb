class AddAbsoluteNumberToLines < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :absolute_number, :integer
  end
end
