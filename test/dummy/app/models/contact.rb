class Contact < ApplicationRecord
  has_many :siblings, dependent: :destroy
  accepts_nested_attributes_for :siblings, allow_destroy: true

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
