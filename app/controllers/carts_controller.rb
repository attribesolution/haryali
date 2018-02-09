class CartsController < ApplicationController

  def cart
    @categories = Category.all
    @subcategories = SubCategory.all.order(id: :asc)
    if params[:id]
      @products = Product.where(sub_category_id: params[:id])
      respond_to :js
    else
      @products = @subcategories.first.products
    end
  end

  def your_cart
  end

  def payment_details
  end

end
