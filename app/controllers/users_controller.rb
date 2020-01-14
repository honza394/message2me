class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the chatroom #{@user.username}"
      redirect_to root_path
    else
      flash.now[:error] = "User already exists, user Log in form"
      render 'sessions/new'
      # redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
