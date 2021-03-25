class ApplicationController < ActionController::Base
    include SessionsHelper

    private
    def logged_in_user
        unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
        end
    end
end

# the backend controller will have 2 endpoints. 1 to receive the image (data64 string i think) and the message 
# and return steg image (data64 string) and another to receive the image and return the message string
