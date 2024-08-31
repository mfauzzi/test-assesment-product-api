class ProductMailer < ApplicationMailer
    default from: 'notifications@example.com'
  
    def product_active_email
      @product = params[:product]
      @user = @product.user
      @url = 'http://example.com/products/' + @product.id.to_s
  
      mail(to: @user.email, subject: 'Produk Baru Anda Aktif!')
    end
  end
  