require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'Validations' do 
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end
  describe 'Relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should have_many(:transactions).through(:invoice) }
  end
end