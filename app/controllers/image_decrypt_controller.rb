require 'base64'

class ImageEncryptController
    def decrypt(image_file)
        #call the steg file in lib
        steg = Steganography.new(filename: image_file)
        return steg.decode()
    end
end