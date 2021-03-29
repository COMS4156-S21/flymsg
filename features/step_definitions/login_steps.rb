require "constants"
require "base64"
require "steganography"
require "encryption"


Given /user (.*) has an account/ do |username|
    user = User.find_by(email: "#{username}@#{username}.com")
    if user == nil
        pem = Encryption.new_key
        hs = Encryption.hash_password("#{username}")
        user_id = SecureRandom.uuid
        email = "#{username}@#{username}.com"
        first_name = "#{username}"
        last_name = "#{username}"
        User.create({:user_id => user_id, :email => email, :first_name => first_name, :last_name => last_name, :hashed_pwd => hs["pwd_hash"], :salt => hs["salt"]})
        UserKey.create({:user_id => user_id, :pem => pem})
    end
end


Given /user (.*) does not have an account/ do |username|
    user = User.find_by(email: "#{username}@#{username}.com")
    if user != nil
        User.destroy(user_id: user.user_id)
        UserKey.destroy(user_id: user.user_id)
    end
end

Given /I have an account/ do
    step %{user akhil has an account}
end


Given /I do not have an account/ do
    step %{user akhil does not have an account}
end


And /user (.*) logs in/ do |username|
    step %{I go to the login page}
    step %{I fill in "email" with "#{username}@#{username}.com"}
    step %{I fill in "pwd" with "#{username}"}
    step %{I press "commit"}
end

And /I log in$/ do
    step %{user akhil logs in}
end

And /I logout$/ do
    step %{I go to the logout page}
end

And /I log in with incorrect password/ do
    username = "akhil"
    step %{I fill in "email" with "#{username}@#{username}.com"}
    step %{I fill in "pwd" with "#{username}lol"}
    step %{I press "commit"}
end

And /I log in with incorrect email/ do
    username = "akhil"
    step %{I fill in "email" with "#{username}lol@#{username}.com"}
    step %{I fill in "pwd" with "#{username}"}
    step %{I press "commit"}
end


Then /user (.*) is logged in/ do |username|
    step %{I go to the encrypt page}
    step %{I should see "Encrypt"}
    step %{I should not see "Login"}
end

Then /I am logged in/ do
    step %{user akhil is logged in}
end