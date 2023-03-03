class Comment < ApplicationRecord
  belongs_to :lesson

  belongs_to :user 

  # turbo stream for live updates
  after_update_commit -> {broadcast_replace_to 'comments'}
  
  after_destroy_commit -> {broadcast_remove_to 'comments'}
end
