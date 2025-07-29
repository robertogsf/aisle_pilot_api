class Product < ApplicationRecord
  has_many :store_products
  has_many :shopping_list_items
end
