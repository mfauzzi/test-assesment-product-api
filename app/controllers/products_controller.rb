class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    @products = Product.includes(:user).all
    render json: @products
  end

  # GET /products/:id
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    user = User.find_by(id: params[:product][:user_id])
    if user.nil?
      render json: { error: 'User not found' }, status: :not_found
      return
    end
    @product.user = user
    if @product.save
      # Prepare a simple hash for broadcasting
      product_data = {
        id: @product.id,
        name: @product.name,
        price: @product.price,
        category: @product.category,
        is_active: @product.is_active,
        user: {
          name: @product.user.name,
          email: @product.user.email
        }
      }
      # Broadcast the product creation to all subscribers
      ActionCable.server.broadcast('products_channel', product_data)
      # Enqueue a job to set `is_active` to true after 3 minutes
      SetProductActiveJob.set(wait: 3.minutes).perform_later(@product.id)
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :category, :image, :user_id)
  end
end
