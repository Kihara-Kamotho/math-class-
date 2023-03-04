class Answer < ApplicationRecord
  belongs_to :question

  after_create_commit -> {broadcast_append_to 'answers'}
  after_update_commit -> {broadcast_replace_to 'answers'}
  after_destroy_commit -> {broadcast_remove_to 'answers'}
end
