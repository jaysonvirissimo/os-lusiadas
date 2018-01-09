class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.references :line, foreign_key: true
      t.string :value
      t.integer :position

      t.timestamps
    end
  end
end
