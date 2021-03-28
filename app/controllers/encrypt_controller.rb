require "base64"
require "steganography"
require "constants"

class EncryptController < ApplicationController
    before_action :logged_in_user

    def create
        encode(params[:image], params[:message])
    end

    def index
        @targeted = params.has_key?(:targeted) && params[:targeted] == "true"
    end

    #will have one default image??
    def encode(image, message)
        tempfile_path = image.tempfile.path
        file_name = image.original_filename

        steg = Steganography.new(filename: tempfile_path)
        full_steg_file_name = "#{STEG_IMG_STORAGE}/#{file_name}"
        steg.encode(message: message, stego_filename: full_steg_file_name)

  #    Title: Uploading an Object to an Amazon S3 Bucket
  #    Author: Amazon.com/Amazon Web Services 
  #    Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html          
        
        bucket_name = 'flymsg1'
        object_key = full_steg_file_name
        region = 'us-east-2'
        s3_client = Aws::S3::Client.new(region: region)

        if object_uploaded?(s3_client, bucket_name, object_key)
          puts "Object '#{object_key}' uploaded to bucket '#{bucket_name}'."
        else
          puts "Object '#{object_key}' not uploaded to bucket '#{bucket_name}'."
        end        

        redirect_to view_path(Base64.strict_encode64(file_name))
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
end
