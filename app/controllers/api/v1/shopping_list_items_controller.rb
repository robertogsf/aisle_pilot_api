class Api::V1::ShoppingListItemsController < ApplicationController
  before_action :authorize_user
  before_action :set_shopping_list

  # POST /api/v1/shopping_lists/:shopping_list_id/shopping_list_items
  def create
    product = Product.find_by(id: params[:product_id])
    unless product
      return render json: { error: "Product not found" }, status: :not_found
    end

    item = @shopping_list.shopping_list_items.new(
      product_id: product.id,
      quantity: params[:quantity] || 1
    )

    if item.save
      render json: item_response(item), status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/shopping_lists/:shopping_list_id/shopping_list_items/:id
  def destroy
    item = @shopping_list.shopping_list_items.find_by(id: params[:id])
    if item
      item.destroy
      render json: { message: "Item removed" }, status: :ok
    else
      render json: { error: "Item not found" }, status: :not_found
    end
  end

  private

  def set_shopping_list
    @shopping_list = current_user.shopping_lists.find_by(id: params[:shopping_list_id])
    render json: { error: "Shopping list not found" }, status: :not_found unless @shopping_list
  end

  def item_response(item)
    {
      id: item.id,
      product_id: item.product.id,
      product_name: item.product.name,
      quantity: item.quantity
    }
  end
end
