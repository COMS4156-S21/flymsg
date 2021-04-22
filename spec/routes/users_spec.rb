require 'rails_helper'
require 'capybara'
require 'base64'
require 'helpers/login_helper'

describe "Visit users endpoint", :type => :request do
    before(:all) do
        create_account
        post '/login', params: {:email => EMAIL, :pwd => PWD}
    end

    after :all do
        get '/logout'
    end

    context "attempt to create user without last_name" do
        it "redirects to the create page with the error" do
            post '/create', :params => {
                :email => "random@random.com",
                :pwd => "randompwdrandompwdrandompwd",
                :first_name => "random"
            }
            
            expect(response).to redirect_to(create_path())
            follow_redirect!
            expect(response.body).to include("Please provide last name")
        end
    end

    context "attempt to create user without first_name" do
        it "redirects to the create page with the error" do
            post '/create', :params => {
                :email => "random@random.com",
                :pwd => "randompwdrandompwdrandompwd",
                :last_name => "random"
            }
            
            expect(response).to redirect_to(create_path())
            follow_redirect!
            expect(response.body).to include("Please provide first name")
        end
    end

    context "attempt to create user with invalid email" do
        it "redirects to the create page with the error" do
            post '/create', :params => {
                :email => "random",
                :pwd => "randompwdrandompwdrandompwd",
                :last_name => "random",
                :first_name => "random"
            }
            
            expect(response).to redirect_to(create_path())
            follow_redirect!
            expect(response.body).to include("Please provide a valid email address")
        end
    end

    context "attempt to create user without email" do
        it "redirects to the create page with the error" do
            post '/create', :params => {
                :pwd => "randompwdrandompwdrandompwd",
                :last_name => "random",
                :first_name => "random"
            }
            
            expect(response).to redirect_to(create_path())
            follow_redirect!
            expect(response.body).to include("Please provide a valid email address")
        end
    end

    context "attempt to create user without password" do
        it "redirects to the create page with the error" do
            post '/create', :params => {
                :email => "random@random.com",
                :last_name => "random",
                :first_name => "random"
            }
            
            expect(response).to redirect_to(create_path())
            follow_redirect!
            expect(response.body).to include("Please provide a password that is at least 3 characters long")
        end
    end

    context "attempt to create user without 2 char password" do
        it "redirects to the create page with the error" do
            post '/create', :params => {
                :email => "random@random.com",
                :last_name => "random",
                :first_name => "random",
                :pwd => "ak"
            }
            
            expect(response).to redirect_to(create_path())
            follow_redirect!
            expect(response.body).to include("Please provide a password that is at least 3 characters long")
        end
    end
end
