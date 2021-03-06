require 'rails_helper'
require 'capybara'
require 'steganography'
require 'helpers/login_helper'

file_name = "ms.png"
steg_file_name = "ms_steg.png"
message = "hello test"
test_source_filename = "#{Rails.root.join("spec").join("support")}/#{file_name}"
test_steg_filename = "#{Rails.root.join("spec").join("support")}/#{steg_file_name}"


describe EncryptController, type: :controller do
    before(:all) do
        create_account
    end

    context "upload an image with a message" do
        it "provides the encoded image for download" do
            post :create, :params => {
                :image => Rack::Test::UploadedFile.new(test_source_filename, "image/png"),
                :message => message
            }, session: SESSION_OBJ
            
            expect(response).to redirect_to(view_path(Base64.strict_encode64(file_name)))
        end
    end

    context "upload an image with a message and receiver email" do
        it "provides the encoded image for download" do
            post :create, :params => {
                :image => Rack::Test::UploadedFile.new(test_source_filename, "image/png"),
                :message => message,
                :receiver_email => EMAIL
            }, session: SESSION_OBJ
            
            expect(response).to redirect_to(view_path(Base64.strict_encode64(file_name)))
        end
    end

    context "upload an image with a message and incorrect receiver email" do
        it "redirect to encrypt page" do
            post :create, :params => {
                :image => Rack::Test::UploadedFile.new(test_source_filename, "image/png"),
                :message => message,
                :receiver_email => "lol@lol.com"
            }, session: SESSION_OBJ
            
            expect(response).to redirect_to(encrypt_index_path())
        end
    end
end