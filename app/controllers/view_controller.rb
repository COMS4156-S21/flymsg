require 'base64'
require 'constants'

class ViewController < ApplicationController

    def show
        @file_name = "#{STEG_IMG_STORAGE}/#{Base64.decode64(params[:id])}"
        @file_data = Base64.encode64(File.open(@file_name , "rb").read)
    end

    def getImage64()
        file = params[:filename]
        full_steg_file_name = "#{STEG_IMG_STORAGE}/#{file}"
        return Steganography.img_in_base64()
    end

    def download
        full_steg_file_name = params[:file_name]
        send_file full_steg_file_name, :type=>"application/png", :x_sendfile=>true
    end
end 