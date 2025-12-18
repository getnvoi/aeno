class Phone < ApplicationRecord
  belongs_to :sibling

  validates :number, presence: true
end
