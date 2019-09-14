# frozen_string_literal: true

class CreateActiveRecallTables < ActiveRecord::Migration[5.2]
  def self.up
    create_table :active_recall_decks do |t|
      t.references :user, polymorphic: true
      t.timestamps
    end
    add_index :active_recall_decks, %i[user_id user_type]

    create_table :active_recall_items do |t|
      t.references  :deck
      t.references  :source, polymorphic: true
      t.integer     :box, default: 0
      t.timestamp   :last_reviewed
      t.timestamp   :next_review
      t.timestamps
    end
    add_index :active_recall_items, %i[source_id source_type]
  end

  def self.down
    drop_table :active_recall_decks
    drop_table :active_recall_items
  end
end
