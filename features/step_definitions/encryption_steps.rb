require "constants"
require "base64"
require "steganography"
require "encryption"

default_image_path = "#{Rails.root.join("spec").join("support")}"
default_stego_path = "#{Rails.root.join("storage").join("steg_img")}"

When /I upload an image "(.*)" for encryption/ do |file_name|
    step %{I attach the file "#{default_image_path}/#{file_name}" to "image"}
end 

When /I upload an image "(.*)" for decryption/ do |file_name|
    step %{I attach the file "#{default_stego_path}/#{file_name}" to "image"}
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

And /I enter test user email for decryption/ do
    step %{I fill in "sender_email" with "test@test.com"}
end

And /I enter random user email for decryption/ do
    step %{I fill in "sender_email" with "random@random.com"}
end

And /I enter test user email for encryption/ do
    step %{I fill in "receiver_email" with "test@test.com"}
end

And /I enter random user email for encryption/ do
    step %{I fill in "receiver_email" with "random@random.com"}
end