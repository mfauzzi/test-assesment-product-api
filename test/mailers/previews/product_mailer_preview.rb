# Preview all emails at http://localhost:3000/rails/mailers/product_mailer
class ProductMailerPreview < ActionMailer::Preview
    def product_active_email
      product = Product.first
      ProductMailer.product_active_email(product)
    end
end  