class AddReadTranslationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :read_translation, :boolean, default: true
  end
end
