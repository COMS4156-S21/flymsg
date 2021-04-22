# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'
require 'encryption'


pem = Encryption.new_key
hs = Encryption.hash_password("test")
user_id = SecureRandom.uuid
email = "test@test.com"
first_name = "test"
last_name = "test"

User.create({:user_id => user_id, :email => email, :first_name => first_name, :last_name => last_name, :hashed_pwd => hs["pwd_hash"], :salt => hs["salt"]})
UserKey.create({:user_id => user_id, :pem => pem})
