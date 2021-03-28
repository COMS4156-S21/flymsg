require 'rails_helper'
require 'capybara'
require 'base64'

message = "hello test"

describe "Visit decrypt endpoint", :type => :request do
    context "visit decrypt endpoint" do
        it "contains the form with correct fields" do
            get "/decrypt"

            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).to include("key")
            expect(response.body).to include("Decrypt")
        end
    end

    context "visit public decrypt endpoint" do
        it "contains the form with correct fields" do
            get "/decrypt?targeted=false"

            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).to include("key")
            expect(response.body).to include("Decrypt")
        end
    end

    context "visit targeted decrypt endpoint" do
        it "contains the form with correct fields" do
            get "/decrypt?targeted=true"

            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).not_to include("key")
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