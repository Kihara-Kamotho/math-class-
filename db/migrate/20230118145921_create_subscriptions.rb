class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, null: false, foreign_key: true 
      t.belongs_to :course, null: false, foreign_key: true
      t.boolean :subscribed, default: false
      
      t.timestamps
    end
  end
end
