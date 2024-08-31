class SetProductActiveJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find_by(id: product_id)
    if product
      product.update(is_active: true)
    else
      Rails.logger.error("Product with ID #{product_id} not found")
    end
  end
end
