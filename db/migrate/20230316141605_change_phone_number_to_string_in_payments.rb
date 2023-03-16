class ChangePhoneNumberToStringInPayments < ActiveRecord::Migration[7.0]
  def change
    change_column :payments, :phone, :string
  end
end
