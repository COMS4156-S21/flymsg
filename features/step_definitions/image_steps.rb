require 'uri'
require 'cgi'
require "base64"
require "steganography"
require 'steganography_ex'
require 'aws-sdk'
require 'aws-sdk-s3'

When /ASCII (.*) and (.*) are passed/ do |message, image|
    message = "hello test"
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/ms.png"
end 

Then /ASCII (.*) should be encoded inside (.*)/ do |message, image|
    message = "hello test"
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/ms.png"
    steg = Steganography.new(filename: image)  
    steg.encode(message: message, stego_filename: image)
end

Then /I should be on the view page for (.*)/ do |image|
    view_path(Base64.strict_encode64(image))
end

When /(.*) gets passed/ do |image|
    curr_dir =  "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/ms.png"
end 

Then /ASCII (.*) should be decoded/ do |message|
    message = "hello test"
    curr_dir =  "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/ms.png"
    steg = Steganography.new(filename: image)
    text = steg.decode()
    expect(text).to eq(message)    
end

Then /S3 bucket should decode ASCII (.*)/ do |message|
    message = "hello test"
    curr_dir =  "#{File.expand_path File.dirname(__FILE__)}"
    link = "http://flymsg1.s3.us-east-2.amazonaws.com/ms.png"
    image = "#{curr_dir}/../../spec/support/ms.png"
    steg = Steganography.new(filename: image)
    text = steg.decode()
    expect(text).to eq(message)  
end

When /Illegal (.*) that is not ASCII is passed with (.*)/ do |message, image|
    message = "भारत"
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/ms.png"
end

Then /NON-ASCII SteganographyException (.*) should be raised/ do |error|
    message = "भारत"
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/ms.png"
    steg = Steganography.new(filename: image)
    error = SteganographyException
    expect { 
    steg.encode(message: message, stego_filename: image)
}.to raise_error(error)    
end 

When /ASCII (.*) that is bigger than (.*) is passed/ do |message, image| 
    message = "hello test"
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/1x1.png"
end 

Then /Message too large for image SteganographyException (.*) should be raised/ do |error|
    message = "hello test"
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/1x1.png"
    steg = Steganography.new(filename: image)
    error = SteganographyException
    expect { 
    steg.encode(message: message, stego_filename: image)
}.to raise_error(error)  
end 

When /(.*) is encoded in base64 (.*)/ do |image, string|
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/1x1.png"    
    string = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEUAAACnej3aAAAAAXRSTlMAQObYZgAAAApJREFUCNdjYAAAAAIAAeIhvDMAAAAASUVORK5CYII="
end 

Then /correct (.*) is returned/ do |string|
    curr_dir = "#{File.expand_path File.dirname(__FILE__)}"
    image = "#{curr_dir}/../../spec/support/1x1.png"    
    string = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEUAAACnej3aAAAAAXRSTlMAQObYZgAAAApJREFUCNdjYAAAAAIAAeIhvDMAAAAASUVORK5CYII="    
    steg = Steganography.new(filename: image)
    expect(steg.img_in_base64(filename: image)).to eq(string)    
end 

Then /uploaded to S3 bucket/ do 
#   Title: Uploading an Object to an Amazon S3 Bucket
#   Author: Amazon.com/Amazon Web Services 
#   Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html      
    bucket_name = 'flymsg1'
    object_key = 'image.png'
    region = 'us-east-2'
    s3_client = Aws::S3::Client.new(region: region, access_key_id: 'AKIASPWQ335UAOAWCBFH', secret_access_key: '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')
    response = s3_client.put_object(
        bucket: bucket_name,
        key: object_key
      )  
    response.etag      
end 

Then /MissingCredentialsError should be raised/ do 
#   Title: Uploading an Object to an Amazon S3 Bucket
#   Author: Amazon.com/Amazon Web Services 
#   Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html  
    region = 'us-east-2'
    expect { 
        s3_client = Aws::S3::Client.new(region: region)
    }.to raise_error(Aws::Sigv4::Errors::MissingCredentialsError)
end

Then /Bucket parameter missing ArgumentError should be raised/ do 
#   Title: Uploading an Object to an Amazon S3 Bucket
#   Author: Amazon.com/Amazon Web Services 
#   Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html      
    object_key = 'image.png'
    region = 'us-east-2'
    s3_client = Aws::S3::Client.new(region: region, access_key_id: 'AKIASPWQ335UAOAWCBFH', secret_access_key: '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')
    expect{ 
        response = s3_client.put_object(
            key: object_key
          ) 
    }.to raise_error(ArgumentError)  
end 

Then /Object key parameter missing ArgumentError should be raised/ do 
#   Title: Uploading an Object to an Amazon S3 Bucket
#   Author: Amazon.com/Amazon Web Services 
#   Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html      
    bucket_name = 'flymsg1'
    region = 'us-east-2'
    s3_client = Aws::S3::Client.new(region: region, access_key_id: 'AKIASPWQ335UAOAWCBFH', secret_access_key: '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')
    expect{ 
        response = s3_client.put_object(
            bucket: bucket_name
          ) 
    }.to raise_error(ArgumentError)  
end 

Then /NetworkingError should be raised/ do 
#   Title: Uploading an Object to an Amazon S3 Bucket
#   Author: Amazon.com/Amazon Web Services 
#   Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html      
    bucket_name = 'flymsg1'
    object_key = 'image.png'
    region = 'us'
    s3_client = Aws::S3::Client.new(region: region, access_key_id: 'AKIASPWQ335UAOAWCBFH', secret_access_key: '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')
    expect{ 
        response = s3_client.put_object(
            bucket: bucket_name,
            key: object_key
          ) 
    }.to raise_error(Seahorse::Client::NetworkingError)      
end 

Then /MissingRegionError should be raised/ do 
#   Title: Uploading an Object to an Amazon S3 Bucket
#   Author: Amazon.com/Amazon Web Services 
#   Availability: https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html  
    expect { 
        s3_client = Aws::S3::Client.new(access_key_id: 'AKIASPWQ335UAOAWCBFH', secret_access_key: 'IwN6DR7q6dSXvTPLJeQA33/R+GmddLTDaCGx6Hp6')
    }.to raise_error(Aws::Errors::MissingRegionError)
end