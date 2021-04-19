require 'encryption'
require 'securerandom'

class UsersController < ApplicationController
  def new
  end

  def user_exists(email)
    return User.find_by(email:  email)
  end

  def create
    vals = user_params
    if user_exists(vals[:email])
      flash[:warning] = "Email already in use"
      redirect_to '/create'
      return
    end


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

    begin 
      User.transaction do 
        @user = User.create!(vals)
        @user_keys = UserKey.create!(key_vals)
      end

      rescue ActiveRecord::RecordInvalid
        flash[:warning] = "Error while creating new user"
        redirect_to 'user#new'
      
      else
        flash[:notice] = "Created! Please login #{params[:first_name]}!"
        redirect_to '/login'
    end
  end

  def user_params
    params.permit(:last_name, :first_name, :email, :pwd)
  end
end
