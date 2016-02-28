class BidsController < ApplicationController
  before_action :authorize_user

  def create
    @product = Product.find(params[:product_id])
    # user = User.find_by(email: params[:user_email])

    @bid = @product.bids.new(bid_params)
    @bid.user_id = current_user.id

    if @bid.valid?
      @bid.save
      redirect_to product_path(@product), notice: 'Bid was successfully created.'
    else
      flash[:alert] = "Can't create bid"
      render "products/show"
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
