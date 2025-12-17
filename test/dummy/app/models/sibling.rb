class Sibling < ApplicationRecord
  belongs_to :contact
  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true
end
