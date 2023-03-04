class Question < ApplicationRecord
  has_many :answers

  after_create_commit -> {broadcast_append_to 'questions'}
  after_update_commit -> {broadcast_replace_to 'questions'}
  after_destroy_commit -> {broadcast_remove_to 'questions'}
end
