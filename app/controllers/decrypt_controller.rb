require "base64"
require "steganography"
require "constants"
require "encryption"

class DecryptController < ApplicationController
    before_action :logged_in_user

    def create
        vals = decode_params
        decode(vals[:image], vals[:sender_email])
    end
 
    def index
        @targeted = params.has_key?(:targeted) && params[:targeted] == "true"
    end

    def show
        @message = Base64.decode64(params[:id])
    end

    def decode(image, sender_email)
        begin 
            tempfile_path = image.tempfile.path
            
            #placeholder code for extracting file path until full S3 integration in the next iteration  
            #tempfile_path = "https://flymsg1.s3.us-east-2.amazonaws.com/" + image.tempfile.path
            
            file_name = image.original_filename

            steg = Steganography.new(filename: tempfile_path)
            message = steg.decode()
            message = manage_message(sender_email, message)

            if message == nil
                return # the flash & redirect will be set by manage_message
            else
                redirect_to decrypt_path(Base64.strict_encode64(message))
            end
        rescue
            flash[:warning] = "Some error!"
            redirect_to decrypt_index_path()
        end
    end 

    def manage_message(sender_email, message)
        begin
            if sender_email != nil
                #puts "sender email set as #{sender_email}"
                user = User.find_by(email: sender_email)
                if user
                    pem = UserKey.find_by(user_id: user.user_id).pem
                    message = Encryption.decrypt_message_public_key(pem: pem, msg: message)
                    #puts "decrypted with pem public key of sender #{sender_email}"
                else
                    #puts "No such user found!!"
                    flash[:warning] =  "No such user found! "
                    redirect_to decrypt_index_path()
                    message = nil
                end
            else
                curr_pem = UserKey.find_by(user_id: session[:user_id]).pem
                message = Encryption.decrypt_message_private_key(pem: curr_pem, msg: message)
                #puts "decrypted with pem private key of current user #{session[:first_name]}"
            end
        rescue
            flash[:warning] = "Unable to find any message!"
            redirect_to decrypt_index_path()
            message = nil
        end
          
        return message
    end

    def decode_params
        params.permit(:image, :id, :targeted, :sender_email)
    end
end