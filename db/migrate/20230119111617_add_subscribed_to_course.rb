class AddSubscribedToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :subscribed, :boolean, default: false
  end
end
