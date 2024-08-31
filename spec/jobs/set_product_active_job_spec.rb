require 'rails_helper'

RSpec.describe SetProductActiveJob, type: :job do
  let!(:user) { User.create(name: 'Test User', email: 'test@example.com') }
  let!(:product) { Product.create(name: 'Test Product', price: 100, category: 'Category', user: user) }

  it 'sets the product as active' do
    # Perform the job
    SetProductActiveJob.perform_now(product.id)
    
    # Reload the product to get the updated attributes
    product.reload

    # Expectation to check if `is_active` is true
    expect(product.is_active).to be_truthy
  end
end
