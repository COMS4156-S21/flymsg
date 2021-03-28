# https://gist.github.com/ostinelli/1770a93d5c01376728c9 - for ECC, but we are going for RSA for ease of encrypt and decrypt
# All keys are base64 PEMs

require 'openssl'
require 'base64'

NUM_ITERATIONS = 20_000

class Encryption
    # returns an app encrypted pem value
    def self.new_key
        return Base64.strict_encode64(OpenSSL::PKey::RSA.new(2048).to_pem)
    end

    # returns a map of hashed password and the salt used
    def self.hash_password(plaintext_password)
        salt = OpenSSL::Random.random_bytes(16)
        value = calc_hash(plaintext_password, salt, NUM_ITERATIONS)
        return {"salt" => salt, "pwd_hash" => value}
    end

    # checks if the hashed password and plaintext are same given the salt
    def self.check_hashed_password(plaintext:, hash:, salt:)
        return OpenSSL.fixed_length_secure_compare(
                    hash,
                    calc_hash(plaintext, salt, NUM_ITERATIONS))
    end

    # encrypt message using private key
    def self.encrypt_message_private_key(pem:, msg:)
        key = key_from_existing(pem)
        return key.private_encrypt(msg)
    end

    # decrypt message using private key
    def self.decrypt_message_private_key(pem:, msg:)
        key = key_from_existing(pem)
        return key.private_decrypt(msg)
    end

    # encrypt message using public key
    def self.encrypt_message_public_key(pem:, msg:)
        key = key_from_existing(pem)
        return key.public_encrypt(msg)
    end

    # decrypt message using public key
    def self.decrypt_message_public_key(pem:, msg:)
        key = key_from_existing(pem)
        return key.public_decrypt(msg)
    end

    private_class_method def self.key_from_existing(pem)
        return OpenSSL::PKey::RSA.new(Base64.decode64(pem))
    end

    private_class_method def self.calc_hash(plaintext_password, salt, iterations)
        hash = OpenSSL::Digest::SHA256.new
        len = hash.digest_length
        return OpenSSL::KDF.pbkdf2_hmac(plaintext_password, salt: salt, iterations: iterations, length: len, hash: hash)
    end
end