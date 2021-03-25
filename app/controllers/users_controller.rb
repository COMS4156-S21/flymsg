class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.create!(user_params)
  end

  def show
  end
  
  def user_params
    params.require(:user).permit(:id, :email, :hashed_pwd)
  end
end
