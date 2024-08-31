require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:user) { User.create(name: "Test User", email: "test@example.com") }
  let(:product) { Product.new(name: 'Product 1', price: 100, category: 'Category 1', user: user) }

  it 'is valid with valid attributes' do
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product.name = nil
    expect(product).to_not be_valid
  end

  it 'is not valid without a price' do
    product.price = nil
    expect(product).to_not be_valid
  end

  it 'is not valid without a category' do
    product.category = nil
    expect(product).to_not be_valid
  end
end
