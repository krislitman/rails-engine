class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items

  enum status: [ 'shipped' ]
end