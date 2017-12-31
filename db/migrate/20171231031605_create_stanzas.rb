class CreateStanzas < ActiveRecord::Migration[5.1]
  def change
    create_table :stanzas do |t|
      t.integer :number
      t.references :canto, foreign_key: true

      t.timestamps
    end
  end
end
