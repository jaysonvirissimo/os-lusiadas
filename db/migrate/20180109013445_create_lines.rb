class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.references :stanza, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
