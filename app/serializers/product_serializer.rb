class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :category, :is_active
  belongs_to :user, serializer: UserSerializer
end
