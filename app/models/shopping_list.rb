class ShoppingList < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :shopping_list_items
end
