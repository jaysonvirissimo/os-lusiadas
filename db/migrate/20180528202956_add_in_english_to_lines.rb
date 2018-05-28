class AddInEnglishToLines < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :in_english, :string
  end
end
