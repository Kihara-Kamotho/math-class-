class AddResponseToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :response, :string
    add_column :payments, :state, :boolean, default: false
    add_column :payments, :code, :string
    add_column :payments, :CheckoutRequestID, :string
    add_column :payments, :MerchantRequestID, :string 
  end
end
