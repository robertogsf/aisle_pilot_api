class Api::V1::ShoppingListsController < ApplicationController
  # before_action :authorize_user

  def index
    @lists = current_user.shopping_lists
    render json: @lists
  end

  def create
    @list = current_user.shopping_lists.create!(shopping_list_params)
    render json: @list, status: :created
  end

  def optimized_order
    list = current_user.shopping_lists.find(params[:id])
    store = list.store

    items = list.shopping_list_items.includes(:product)
    layout = store.layout

    # Example sort: by aisle number (assuming layout includes aisle data)
    sorted_items = items.sort_by do |item|
      store_product = StoreProduct.find_by(store: store, product: item.product)
      store_product&.aisle.to_i || 999
    end

    render json: sorted_items
  end

  private

  def shopping_list_params
    params.require(:shopping_list).permit(:name, :store_id)
  end
end
