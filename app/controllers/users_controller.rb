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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    session[:user_id] = nil
    flash[:danger] = "User and all messages created by user have been deleted"
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
