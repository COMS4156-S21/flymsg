require "base64"
require "steganography"
require "constants"
require "encryption"

class EncryptController < ApplicationController
    before_action :logged_in_user

    def create
        vals = encrypt_params
        encode(vals[:image], vals[:message], vals[:receiver_email])
    end

    def index
        @targeted = params.has_key?(:targeted) && params[:targeted] == "true"
    end

    #will have one default image??
    def encode(image, message, receiver_email)
        begin
          tempfile_path = image.tempfile.path
          file_name = image.original_filename
          message = manage_message(receiver_email, message) 
          
          if message == nil
            return # the flash & redirect will be set by manage_message
          else
            steg = Steganography.new(filename: tempfile_path)
            full_steg_file_name = "#{STEG_IMG_STORAGE}/#{file_name}"
            steg.encode(message: message, stego_filename: full_steg_file_name)
            
            # next itr
            # bucket_name = 'flymsg1'
            # object_key = full_steg_file_name
            # region = 'us-east-2'
            # s3_client = Aws::S3::Client.new(region: region)

            # if object_uploaded?(s3_client, bucket_name, object_key)
            #   puts "Object '#{object_key}' uploaded to bucket '#{bucket_name}'."
            # else
            #   puts "Object '#{object_key}' not uploaded to bucket '#{bucket_name}'."
            # end        

            redirect_to view_path(Base64.strict_encode64(file_name))
          end
        rescue
          flash[:warning] = "Some error 2!"
          redirect_to encrypt_index_path()
        end
    end    

    
    # if receiver email is set, encrypt with their public key
    # if not, encrypt with current user's private key
    def manage_message(receiver_email, message)
      begin 
        if receiver_email != nil
          #puts "receiver email set as #{receiver_email}"
          user = User.find_by(email: receiver_email)
          if user
            pem = UserKey.find_by(user_id: user.user_id).pem
            message = Encryption.encrypt_message_public_key(pem: pem, msg: message)
            #puts "encrypted with pem public key of receiver #{receiver_email}"
          else
            #puts "No such user found!!"
            flash[:warning] = "No such user found!"
            redirect_to encrypt_index_path()
            message = nil
          end
        else
          curr_pem = UserKey.find_by(user_id: session[:user_id]).pem
          message = Encryption.encrypt_message_private_key(pem: curr_pem, msg: message)
          #puts "encrypted with pem private key of current user #{session[:first_name]}"
        end
      rescue
        flash[:warning] = "Some error q!"
        message = nil
        redirect_to encrypt_index_path()
      end
      return message
    end



    #    Title: Uploading an Object to an Amazon S3 Bucket
    #    Author: Amazon.com/Amazon Web Services 
    #    Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html  

    def object_uploaded?(s3_client, bucket_name, object_key)
      response = s3_client.put_object(
        bucket: bucket_name,
        key: object_key
      )
      if response.etag
        return true
      else
        return false
      end
    rescue StandardError => e
      puts "Error uploading object: #{e.message}"
      return false
    end    
    
    def encrypt_params
      params.permit(:image, :message, :receiver_email, :targeted)
    end
end
