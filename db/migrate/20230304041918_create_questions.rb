class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :body
      t.belongs_to :lesson

      t.timestamps
    end
  end
end
