class ReviewsController < ApplicationController

  before_action :authorize_user

  def edit
    @review = Review.find(params[:id])
    render :edit
  end

  def update

    @review = Review.find(params[:id])
    @review.update(review_params)

    if @review.valid?
      @review.save
      redirect_to product_path(@review.product), notice: 'Review was successfully updated.'
    else
      flash[:alert] = "Can't update review"
      render :edit
    end
  end

  def create
    @product = Product.find(params[:product_id])

    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.valid?
      @review.save
      redirect_to product_path(@product), notice: 'Review was successfully created.'
    else
      flash[:alert] = "Can't create review"
      render "products/show"
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    Review.destroy(params[:id])
    redirect_to product_path(@product), notice: 'Review was successfully deleted.'
  end

  private

  def review_params
    params.require(:review).permit(:description)
  end

end
