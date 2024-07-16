class UsersController < ApplicationController
  before_action :require_user, only: :show

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      cookies[:location] = params[:location]
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Bad Credentials, try again."
      redirect_to "/login"
    end
  end

  def logout
    session.delete(:user_id)
    flash[:success] = "You have been logged out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def require_user
    if !current_user
      flash[:error] = "you must log in"
      redirect_to root_path
    end
  end
end
