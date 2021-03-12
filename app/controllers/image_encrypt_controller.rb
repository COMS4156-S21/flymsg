require "base64"

class ImageEncryptController 
    #will have one default image??
    def encode(image, message)
        
        image_base64 = Base64.decode64(image)
        image_base64[0,8]
        type = /(png|jpg|jpeg|gif|PNG|JPG|JPEG|GIF)/.match(image_base64[0,16])[0]
        name = "img_file"
        
        file = name << "." << type
        File.open(file, 'wb') do |f|
            f.write(image_base64)
        end
        
        full_file_name = "storage/img" + file
        steg = Steganograaphy.new(filename: full_file_name)
        
        #calling decode
        full_steg_file_name = "storage/steg_img" + file
        return steg.encode(message: message, stego_filename: full_steg_file_name)
        #encrypted_img = img_base64(filename:filename)
        #return encrypted_img
    end
    
    
end
