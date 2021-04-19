require 'encryption'
require 'securerandom'

class UsersController < ApplicationController
  def new
  end

  def user_exists(email)
    return User.find_by(email:  email)
  end

  # returns nil message on valid
  # else provides a error message
  def is_valid_info(vals)
    if vals[:email] and !vals[:email].match "[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
      return "Please provide a valid email address"
    elsif vals[:pwd] and vals[:pwd].length < 3
      return "Please provide a password that is at least 3 characters long"
    elsif vals[:last_name] and vals[:last_name].length < 1
      return "Please provide last name"
    elsif vals[:first_name] and vals[:first_name].length < 1
      return "Please provide first name"
    else
      return nil
    end
  end

  def create
    vals = user_params
    msg = is_valid_info(vals)

    if msg
      flash[:warning] = msg
      redirect_to '/create'
      return
    end

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
