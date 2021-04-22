require 'spec_helper'
require 'rails_helper'

require 'encryption'

describe "While encrypting the message" do
    context "when a plaintext message is passed" do
        it "should return hashed password and salt" do
            val = Encryption.hash_password("hello")
            expect(val).to have_key("salt")
            expect(val).to have_key("pwd_hash")
        end
    end

    context "when a plaintext message is passed" do
        it "it hashes correctly" do
            text = "hello"
            val = Encryption.hash_password(text)
            correct = Encryption.check_hashed_password(plaintext: text, hash: val["pwd_hash"], salt: val["salt"])
            expect(correct).to be true
        end
    end

    context "when message is encrypted with private key" do
        it "it decrypts correctly with public key" do
            message = "hello hello test"
            pem = Encryption.new_key
            enc = Encryption.encrypt_message_private_key(pem: pem, msg: message)
            dcm = Encryption.decrypt_message_public_key(pem: pem, msg: enc)
            expect(dcm).to eq(message)
        end
    end

    context "when message is encrypted with public key" do
        it "it decrypts correctly with private key" do
            message = "hello hello test"
            pem = Encryption.new_key
            enc = Encryption.encrypt_message_public_key(pem: pem, msg: message)
            dcm = Encryption.decrypt_message_private_key(pem: pem, msg: enc)
            expect(dcm).to eq(message)
        end
    end
end