class RemoveEnglishTranslationFromLines < ActiveRecord::Migration[5.1]
  def change
    remove_column :lines, :english_translation
  end
end
