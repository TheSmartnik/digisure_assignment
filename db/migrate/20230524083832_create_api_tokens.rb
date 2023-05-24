class CreateApiTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :api_tokens do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: false
      t.datetime :expires_at
      t.text :token, null: false

      t.timestamps
    end

    add_index :api_tokens, %i[user_id expires_at]
  end
end
