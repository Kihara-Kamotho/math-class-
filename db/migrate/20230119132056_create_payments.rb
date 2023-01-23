class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :amount, :null => false
      t.integer :phone
      t.belongs_to :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
