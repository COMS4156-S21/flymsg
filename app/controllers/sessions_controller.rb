# https://hackernoon.com/building-a-simple-session-based-authentication-using-ruby-on-rails-9tah3y4j

require 'encryption'

class SessionsController < ApplicationController
    def new
        if logged_in?
            redirect_to encrypt_index_path()
        end
    end

    def create
        vals = session_params
        user = User.find_by(email: vals[:email])
        if user && Encryption.check_hashed_password(plaintext: vals[:pwd], hash: user.hashed_pwd, salt: user.salt)
            log_in user
            #puts "good path"
            redirect_to encrypt_index_path()
        else
            #puts "Bad pathxxxx"
            #puts "vals email: " + vals[:email] + ", vals pwd: " + vals[:pwd]
            # if user
            #     #puts "user obj email: " + user.email
            # end
            flash.now[:warning] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end

    def session_params
        params.permit(:email, :pwd)
    end
end
