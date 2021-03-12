require "base64"
require "steganography"

class EncryptController < ActionController::Base
    def create
        encode(params[:image], params[:message])
    end

    def index
    end

    #will have one default image??
    def encode(image, message)
        curr_dir =  "#{File.expand_path File.dirname(__FILE__)}"
        storage_dir = "#{curr_dir}/../../storage"

        tempfile_path = image.tempfile.path
        file_name = image.original_filename

        steg = Steganography.new(filename: tempfile_path)
        full_steg_file_name = "#{storage_dir}/steg_img/" + file_name
        return steg.encode(message: message, stego_filename: full_steg_file_name)
    end    
    
end
