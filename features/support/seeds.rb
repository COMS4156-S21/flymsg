require "constants"
require "base64"
require "steganography"
require "encryption"

pem = Encryption.new_key
hs = Encryption.hash_password("test")
user_id = SecureRandom.uuid
email = "test@test.com"
first_name = "test"
last_name = "test"

User.create({:user_id => user_id, :email => email, :first_name => first_name, :last_name => last_name, :hashed_pwd => hs["pwd_hash"], :salt => hs["salt"]})
UserKey.create({:user_id => user_id, :pem => pem})
puts "=========Seeded for cucumber=============="