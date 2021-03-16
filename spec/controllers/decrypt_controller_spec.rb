require 'rails_helper'
require 'capybara'
require 'steganography'

file_name = "ms.png"
steg_file_name = "ms_steg.png"
message = "hello test"
test_source_filename = "#{Rails.root.join("spec").join("support")}/#{file_name}"
test_steg_filename = "#{Rails.root.join("spec").join("support")}/#{steg_file_name}"


describe DecryptController, type: :controller do
    before :all do
        Steganography
        .new(filename: test_source_filename)
        .encode(message: message, stego_filename: test_steg_filename)
    end

    context "upload a stego image" do
        it "provides the message inside the image" do
            post :create, :params => {
                :image => Rack::Test::UploadedFile.new(test_steg_filename, "image/png"),
            }
            
            expect(response).to redirect_to(decrypt_path(Base64.strict_encode64(message)))
        end
    end
end