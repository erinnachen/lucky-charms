class HomesController < ApplicationController
  before_action :require_admin, only: [:index]

  def show
    flash.now[:success] = "No account required! username: user password: password OR username: admin password: password"
    @items = Item.take(3)
    @categories = Category.take(3)
  end

  def index
    session[:serious] = true
    flash[:success] = "IT'S ON NOW."
    redirect_to root_path
  end
end
