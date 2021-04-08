class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def destroy_invoice
    expected = invoices.joins(:items)
    .select("invoices.*, count(items.*)")
    .group("invoices.id")
    .having("count(items.*) = 1").pluck(:id)
  end
end
