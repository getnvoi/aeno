class Contact < ApplicationRecord
  has_many :siblings, dependent: :destroy
  accepts_nested_attributes_for :siblings, allow_destroy: true
end
