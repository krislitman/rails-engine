class InvoiceFacade
  def self.potential_revenue(quantity)
    quantity = 10 if quantity.nil?
    Invoice.potential_revenue(quantity)
  end
end