class Comment < ApplicationRecord
  belongs_to :lesson

  belongs_to :user 

  # turbo stream for live updates
  after_destroy_commit -> {broadcast_remove_to 'comments'}
end
