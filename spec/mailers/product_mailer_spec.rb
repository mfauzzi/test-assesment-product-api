require "rails_helper"

RSpec.describe ProductMailer, type: :mailer do
  describe "product_active_email" do
    let!(:user) { User.create(name: 'Test User', email: 'test@example.com') }
    let!(:product) { 
        Product.create(
          name: 'Test Product', 
          price: 100, 
          category: 'Category', 
          user: user, 
          image: fixture_file_upload('files/test_image_new.png', 'image/png')
        ) 
      }           
    let(:mail) { ProductMailer.product_active_email(product) }

    it "renders the headers" do
      expect(mail.subject).to eq('Your product is now active!')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(product.name)
      expect(mail.body.encoded).to match(product.price.to_s)
      expect(mail.body.encoded).to match(product.category)
      expect(mail.body.encoded).to match('Product Image')
    end
  end
end
