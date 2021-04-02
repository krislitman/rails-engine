require 'rails_helper'

RSpec.describe Invoice do
  describe 'Validations' do 
    it { should validate_presence_of :status }
  end
  describe 'Relationships' do
    it { should have_many :transactions}
    it { should belong_to :merchant }
    it { should belong_to :customer }
  end
end