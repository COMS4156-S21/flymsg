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

    def download
        curr_dir =  "#{File.expand_path File.dirname(__FILE__)}"
        storage_dir = "#{curr_dir}/../../storage"
        full_steg_file_name = "#{storage_dir}/steg_img/" + params[:file_name]
        
        send_file full_steg_file_name, :type=>"application/png", :x_sendfile=>true
    end
end 