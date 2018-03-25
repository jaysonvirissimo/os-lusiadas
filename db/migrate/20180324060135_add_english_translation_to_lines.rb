class AddEnglishTranslationToLines < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :english_translation, :string
  end
end
