require 'uri'
require 'cgi'
require "base64"
require "steganography"
require 'steganography_ex'

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