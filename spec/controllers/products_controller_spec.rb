require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:user) { User.create(name: "Test User", email: "test@example.com") }
  let(:valid_attributes) do
    { name: 'Product 1', price: 100, category: 'Category 1', user_id: user.id }
  end
  let(:invalid_attributes) do
    { name: nil, price: nil, category: nil, user_id: user.id }
  end

  describe "GET #index" do
    it "returns a success response" do
      Product.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get :show, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it "broadcasts the product" do
        expect {
          post :create, params: { product: valid_attributes }
        }.to have_broadcasted_to('products_channel')
      end

      it "renders a JSON response with the new product" do
        post :create, params: { product: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the new product" do
        post :create, params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    let!(:product) { Product.create! valid_attributes }

    context "with valid parameters" do
      let(:new_attributes) do
        { name: 'Updated Product' }
      end

      it "updates the requested product" do
        patch :update, params: { id: product.to_param, product: new_attributes }
        product.reload
        expect(product.name).to eq('Updated Product')
      end

      it "renders a JSON response with the product" do
        patch :update, params: { id: product.to_param, product: new_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the product" do
        patch :update, params: { id: product.to_param, product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:product) { Product.create! valid_attributes }

    it "destroys the requested product" do
      expect {
        delete :destroy, params: { id: product.to_param }
      }.to change(Product, :count).by(-1)
    end

    it "returns a success response" do
      delete :destroy, params: { id: product.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end