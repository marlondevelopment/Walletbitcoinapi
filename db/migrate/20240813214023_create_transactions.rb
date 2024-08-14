class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.float :amount_sent
      t.float :amount_received
      t.string :currency_sent
      t.string :currency_received
      t.float :btc_price_at_transaction
      t.string :transaction_type

      t.timestamps
    end
  end
end
