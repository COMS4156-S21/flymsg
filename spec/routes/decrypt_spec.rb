require 'rails_helper'
require 'capybara'
require 'base64'
require 'helpers/login_helper'

message = "hello test"

describe "Visit decrypt endpoint", :type => :request do
    before(:all) do
        create_account
        post '/login', params: {:email => EMAIL, :pwd => PWD}
    end

    context "visit decrypt endpoint" do
        it "contains the form with correct fields" do
            get "/decrypt"

            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).to include("sender_email")
            expect(response.body).to include("Decrypt")
        end
    end

    context "visit public decrypt endpoint" do
        it "contains the form with correct fields" do
            get "/decrypt?targeted=false"

            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).to include("sender_email")
            expect(response.body).to include("Decrypt")
        end
    end

    context "visit targeted decrypt endpoint" do
        it "contains the form with correct fields" do
            get "/decrypt?targeted=true"

            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).not_to include("sender_email")
            expect(response.body).to include("Decrypt")
        end
    end

    context "visit decrypt endpoint with message" do
        it "shows the message" do
            get "/decrypt/#{Base64.strict_encode64(message)}"

            expect(response).to render_template("show")
            expect(response.body).to include("Message Decrypted!")
            expect(response.body).to include(message)
        end
    end
end