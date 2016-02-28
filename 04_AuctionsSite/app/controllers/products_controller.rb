class ProductsController < ApplicationController

  before_action :authorize_user, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id]) || (render "layouts/404")
    @bid = Bid.new
    # @review = Review.new
  end

  def new
    @product = Product.new
  end

  def create

    @product = current_user.products.new(product_params)

    if @product.valid?
      @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      flash[:alert] = "Can't create product"
      render :new
    end
  end

  def destroy
    Product.destroy(params[:id])
    redirect_to products_path, notice: 'Product was successfully deleted.'
  end

  private

  def product_params
		params.require(:product).permit(:title, :description, :bidding_deadline, :minimum_bid)
  end

end
