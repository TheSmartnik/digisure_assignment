class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :operation_type, null: false
      t.bigint :quantity, null: false, default: 0
      t.jsonb :data, null: false, default: {}

      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
