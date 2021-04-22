require 'encryption'

USER_ID = SecureRandom.uuid
EMAIL = "test@test.com"
FIRST_NAME = "test"
LAST_NAME = "test"
PWD = "test"
PEM = Encryption.new_key
HS = Encryption.hash_password(PWD)

SESSION_OBJ = {:user_id => USER_ID, :first_name => FIRST_NAME}

def create_account
    user = User.find_by(email: EMAIL)
    if user != nil
        user.destroy
    end
    User.create({:user_id => USER_ID, :email => EMAIL, :first_name => FIRST_NAME, :last_name => LAST_NAME, :hashed_pwd => HS["pwd_hash"], :salt => HS["salt"]})
    UserKey.create({:user_id => USER_ID, :pem => PEM})
end