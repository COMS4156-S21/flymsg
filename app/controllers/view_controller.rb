require "base64" 

class ViewController < ActionController::Base

    def index
    end

    def show
        @file_name = Base64.decode64(params[:id])
    end

    def getImage64()
        file = params[:filename]
        full_steg_file_name = "storage/steg_img" + file
        return Steganography.img_in_base64()
    end 
end 