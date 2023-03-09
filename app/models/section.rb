# frozen_string_literal: true

class Section < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :course
  has_many :lessons

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
