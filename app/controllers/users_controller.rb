require 'encryption'
require 'securerandom'

class UsersController < ApplicationController
  def new
  end

  def create
    vals = user_params

    user_id = SecureRandom.uuid
    hash = Encryption.hash_password(vals[:pwd])
    hashed_pwd = hash["pwd_hash"]
    salt = hash["salt"]
    vals.delete(:pwd)

    vals[:user_id] = user_id
    vals[:hashed_pwd] = hashed_pwd
    vals[:salt] = salt

    pem = Encryption.new_key
    key_vals = {:user_id => user_id, :pem => pem}

    User.transaction do 
      @user = User.create!(vals)
      @user_keys = UserKeys.create!(key_vals)
    end

    rescue ActiveRecord::RecordInvalid
      flash[:failure] = "Error while creating new user"
      redirect_to 'user#new'
    end
    
    flash[:success] = "Created! Please login #{params[:first_name]}!"
    redirect_to 'login'
  end
  
  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :pwd)
  end
end
