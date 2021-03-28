require "constants"
require "base64"
require "steganography"
require "encryption"

default_image_path = "#{Rails.root.join("spec").join("support")}"
default_stego_path = "#{Rails.root.join("spec").join("support").join("ms_steg.png")}"

When /I upload an image "(.*)"/ do |file_name|
    step %{I attach the file "#{default_image_path}/#{file_name}" to "image"}
end 

And /I enter the message "(.*)"/ do |message|
    step %{I fill in "message" with "#{message}"}
end

And /I click encrypt/ do
    step %{I press "commit"}
end

And /I click decrypt/ do
    step %{I press "commit"}
end

And /be able to download the image/ do
    field = find_field("Download")
    puts "Field: ", field
end