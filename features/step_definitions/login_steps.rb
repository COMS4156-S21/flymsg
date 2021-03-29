require "constants"
require "base64"
require "steganography"
require "encryption"


Given /test user has an account/ do
    user = User.find_by(email: "test@test.com")
    if user != nil
        pem = Encryption.new_key
        hs = Encryption.hash_password("test")
        user_id = SecureRandom.uuid
        email = "test@test.com"
        first_name = "test"
        last_name = "test"

        User.create({:user_id => user_id, :email => email, :first_name => first_name, :last_name => last_name, :hashed_pwd => hs["pwd_hash"], :salt => hs["salt"]})
        UserKey.create({:user_id => user_id, :pem => pem})
    end
end

And /test user logs in/ do
    step %{I go to the login page}
    step %{I fill in "email" with "test@test.com"}
    step %{I fill in "pwd" with "test"}
    step %{I press "commit"}
end

And /test user is logged in/ do
    step %{I go to the encrypt page}
    step %{I should see "Encrypt"}
    step %{I should not see "Login"}
end