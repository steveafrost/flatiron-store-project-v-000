class StoreController < ApplicationController

  def index
    @categories = Category.all
    @items = Item.all.where("inventory > ?", 0)
  end

end
