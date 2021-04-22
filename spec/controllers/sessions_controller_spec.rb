require 'rails_helper'
require 'capybara'
require 'steganography'
require 'helpers/login_helper'

file_name = "ms.png"
steg_file_name = "ms_steg.png"
message = "hello test"
test_source_filename = "#{Rails.root.join("spec").join("support")}/#{file_name}"
test_steg_filename = "#{Rails.root.join("spec").join("support")}/#{steg_file_name}"


describe SessionsController, type: :controller do

    context "visit login page without logging in" do
        render_views
        it "shows the login form" do
            get :new
            expect(response.body).to include("Login")
            expect(response.body).to include("email")
            expect(response.body).to include("pwd")
        end
    end

    context "attempt to login with incorrect credentials" do
        render_views
        it "show login form with erorr message" do
            post :create, :params => {
                :email => "random@random.com",
                :pwd => "randompwd"
            }
            
            expect(response.body).to include("Login")
            expect(response.body).to include("email")
            expect(response.body).to include("pwd")
            expect(response.body).to include("Invalid email/password combination")
        end
    end

    context "attempt to login with correct credentials" do
        it "expect redirect to encrypt" do
            create_account
            post :create, :params => {
                :email => "test@test.com",
                :pwd => "test"
            }
            expect(response).to redirect_to(encrypt_index_path())
        end
    end

    context "attempt to login with correct credentials and then logout" do
        it "expect redirect back to login" do
            create_account
            post :create, :params => {
                :email => "test@test.com",
                :pwd => "test"
            }
            expect(response).to redirect_to(encrypt_index_path())

            get :destroy
            expect(response).to redirect_to(root_url)

        end
    end
end