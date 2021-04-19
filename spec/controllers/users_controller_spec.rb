require 'rails_helper'
require 'capybara'
require 'steganography'
require 'helpers/login_helper'

file_name = "ms.png"
steg_file_name = "ms_steg.png"
message = "hello test"
test_source_filename = "#{Rails.root.join("spec").join("support")}/#{file_name}"
test_steg_filename = "#{Rails.root.join("spec").join("support")}/#{steg_file_name}"


describe UsersController, type: :controller do

    context "visit users new page" do
        render_views
        it "shows the users new page" do
            get :new
            expect(response.body).to include("first_name")
            expect(response.body).to include("email")
            expect(response.body).to include("last_name")
            expect(response.body).to include("pwd")
        end
    end

    context "attempt to create user" do
        it "creates and redirects to the login page" do
            post :create, :params => {
                :email => "random@random.com",
                :pwd => "randompwdrandompwdrandompwd"
            }
            
            expect(response).to redirect_to(login_path())
        end
    end
end