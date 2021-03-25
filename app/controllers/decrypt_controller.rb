require "base64"
require "steganography"
require "constants"

class DecryptController < ApplicationController
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
        file_name = image.original_filename

        steg = Steganography.new(filename: tempfile_path)
        message = steg.decode()

        redirect_to decrypt_path(Base64.strict_encode64(message))
    end 
end