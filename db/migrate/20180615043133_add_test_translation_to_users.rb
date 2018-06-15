class AddTestTranslationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :test_translation, :boolean, default: false
  end
end
