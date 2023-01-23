class AddAmountToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :amount, :decimal, :default => 0
  end
end
