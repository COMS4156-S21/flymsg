class ViewController
    
    def getImage64()
        file = params[:filename]
        full_steg_file_name = "storage/steg_img" + file
        return Steganography.img_in_base64()
    end 
end 