class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,                null: false
      t.string :name,                 null: false
      t.string :password_digest,      null: false
      t.string :password_reset_token, null: false, limit: 60

      t.timestamps
    end
  end
end
