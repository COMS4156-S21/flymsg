require "base64"
require "steganography"
require "constants"

class EncryptController < ApplicationController
    before_action :logged_in_user

    def create
        encode(params[:image], params[:message])
    end

    def index
        @targeted = params.has_key?(:targeted) && params[:targeted] == "true"
    end

    #will have one default image??
    def encode(image, message)
        tempfile_path = image.tempfile.path
        file_name = image.original_filename

        steg = Steganography.new(filename: tempfile_path)
        full_steg_file_name = "#{STEG_IMG_STORAGE}/#{file_name}"
        steg.encode(message: message, stego_filename: full_steg_file_name)

        redirect_to view_path(Base64.strict_encode64(file_name))
    end    
    
end
