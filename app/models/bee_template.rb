# frozen_string_literal: true

class BeeTemplate < ApplicationRecord
  validates :name, :content, presence: true
end
