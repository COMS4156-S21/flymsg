require 'rails_helper'
require 'capybara'
require 'base64'

message = "hello test"

describe "Visit encrypt endpoint", :type => :request do
    context "visit encrypt endpoint" do
        it "contains the form with correct fields" do
            get "/encrypt"

            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).to include("message")
            expect(response.body).not_to include("key")
            expect(response.body).to include("Encrypt")
        end
    end
    
    context "visit public encrypt endpoint" do
        it "contains the form with correct fields" do
            get "/encrypt?targeted=false"
    
            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).to include("message")
            expect(response.body).not_to include("key")
            expect(response.body).to include("Encrypt")
        end
    end
    
    context "visit targeted encrypt endpoint" do
        it "contains the form with correct fields" do
            get "/encrypt?targeted=true"
    
            expect(response).to render_template("index")
            expect(response.body).to include("image")
            expect(response.body).to include("message")
            expect(response.body).to include("key")
            expect(response.body).to include("Encrypt")
        end
    end
end
