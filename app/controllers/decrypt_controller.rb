require "base64"
require "steganography"

class DecryptController < ActionController::Base
    def create
        decode(params[:image])
    end

    def index
    end

    def show
        @message = params[:id]
    end

    def decode(image)
        curr_dir =  "#{File.expand_path File.dirname(__FILE__)}"
        storage_dir = "#{curr_dir}/../../storage"

        tempfile_path = image.tempfile.path
        file_name = image.original_filename

        steg = Steganography.new(filename: tempfile_path)
        full_file_name = "#{storage_dir}/img/" + file_name
        message = steg.decode()

        redirect_to decrypt_path(message)
    end 
end