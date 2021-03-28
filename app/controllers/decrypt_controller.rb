require "base64"
require "steganography"
require "constants"

class DecryptController < ApplicationController
    # before_action :logged_in_user

    def create
        decode(params[:image])
    end
 
    def index
        @targeted = params.has_key?(:targeted) && params[:targeted] == "true"
    end

    def show
        @message = Base64.decode64(params[:id])
    end

    def decode(image)
        tempfile_path = image.tempfile.path
        
        #placeholder code for extracting file path until full S3 integration in the next iteration  
        #tempfile_path = "https://flymsg1.s3.us-east-2.amazonaws.com/" + image.tempfile.path
        
        file_name = image.original_filename

        steg = Steganography.new(filename: tempfile_path)
        message = steg.decode()

        redirect_to decrypt_path(Base64.strict_encode64(message))
    end 
end