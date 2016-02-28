class SessionsController < ApplicationController

  before_action :authorize_user, except: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
