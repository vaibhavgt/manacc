class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :category_id
      t.decimal :amount
      t.decimal :current_balance
      t.string :type
      t.timestamps null: false
    end
  end
end
