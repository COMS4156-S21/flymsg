require 'rails_helper'
require 'capybara'
require 'steganography'
require 'helpers/login_helper'
require 'encryption'

file_name = "ms.png"
steg_file_name = "ms_steg.png"
message = "hello test"
pb_enc_message = Encryption.encrypt_message_public_key(pem: PEM, msg: message)
pk_enc_message = Encryption.encrypt_message_private_key(pem: PEM, msg: message)
test_source_filename = "#{Rails.root.join("spec").join("support")}/#{file_name}"
test_steg_filename = "#{Rails.root.join("spec").join("support")}/#{steg_file_name}"


describe DecryptController, type: :controller do
    before :all do
        create_account
    end

    # context "upload a stego image with sender email" do
    #     it "provides the message inside the image" do
    #         Steganography
    #         .new(filename: test_source_filename)
    #         .encode(message: pk_enc_message, stego_filename: test_steg_filename)

    #         post :create, :params => {
    #             :image => Rack::Test::UploadedFile.new(test_steg_filename, "image/png"),
    #             :sender_email => EMAIL
    #         }, session: SESSION_OBJ
            
    #         expect(response).to redirect_to(decrypt_path(Base64.strict_encode64(message)))
    #     end
    # end


    context "upload a stego image" do
        it "provides the message inside the image" do
            Steganography
            .new(filename: test_source_filename)
            .encode(message: pb_enc_message, stego_filename: test_steg_filename)

            post :create, :params => {
                :image => Rack::Test::UploadedFile.new(test_steg_filename, "image/png"),
            }, session: SESSION_OBJ
            
            expect(response).to redirect_to(decrypt_path(Base64.strict_encode64(message)))
        end
    end

end