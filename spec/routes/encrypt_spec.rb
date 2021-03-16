require 'rails_helper'
require 'capybara'
require 'base64'

message = "hello test"

describe "Visit encrypt endpoint", :type => :request do
    context "visit encrypt endpoint" do
        it "contains the form" do
            get "/encrypt"

            expect(response).to render_template("index")
            expect(response.body).to include("input")
            expect(response.body).to include("Encrypt")
        end
    end
end