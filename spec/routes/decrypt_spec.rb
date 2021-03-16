require 'rails_helper'
require 'capybara'
require 'base64'

message = "hello test"

describe "Visit decrypt endpoint", :type => :request do
    context "visit decrypt endpoint" do
        it "contains the form" do
            get "/decrypt"

            expect(response).to render_template("index")
            expect(response.body).to include("input")
            expect(response.body).to include("Decrypt")
        end
    end

    context "visit decrypt endpoint with message" do
        it "shows the message" do
            get "/decrypt/#{Base64.strict_encode64(message)}"

            expect(response).to render_template("show")
            expect(response.body).to include("Decrypted Message")
            expect(response.body).to include(message)
        end
    end
end