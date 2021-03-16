require 'rails_helper'
require 'capybara'
require 'base64'

message = "hello test"
file_name = "ms.png"
steg_file_name = "ms_steg.png"
main_source_filename = test_source_filename = "#{Rails.root.join("spec").join("support")}/#{file_name}"
test_source_filename = "#{Rails.root.join("storage").join("img")}/#{file_name}"
test_steg_filename = "#{Rails.root.join("storage").join("steg_img")}/#{steg_file_name}"

describe "Visit view endpoint", :type => :request do
    before :all do
        FileUtils.cp(main_source_filename, Rails.root.join("storage").join("img"))

        Steganography
        .new(filename: test_source_filename)
        .encode(message: message, stego_filename: test_steg_filename)
    end

    after :all do
        FileUtils.rm(test_source_filename)
        FileUtils.rm(test_steg_filename)
    end

    context "visit with the stego file name" do
        it "contains the image" do
            get "/view/#{Base64.strict_encode64(steg_file_name)}"

            expect(response.body).to include("Download Encrypted Image")
            expect(response.body).to include(Base64.encode64(File.open(test_steg_filename , "rb").read))
        end
    end
end