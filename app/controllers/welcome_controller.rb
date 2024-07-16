class WelcomeController < ApplicationController
  def index
    @users = User.where.not(id: session[:user_id].presence)
  end
end
