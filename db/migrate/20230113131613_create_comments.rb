class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :lesson, null: false, foreign_key: true
      t.belongs_to :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
