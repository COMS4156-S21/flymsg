# https://gist.github.com/ostinelli/1770a93d5c01376728c9

require 'openssl'

NUM_ITERATIONS = 20_000

class Encryption
    # returns a map of public key and private key
    def self.new_key
        key = OpenSSL::PKey::EC.new("secp256k1")
        key.generate_key
        pks = key.private_key.to_s(16)
        pbs = key.public_key.to_bn.to_s(16)
        return {"pks" => pks, "pbs" => pbs}
    end

    def self.calc_hash(plaintext_password, salt, iterations)
        hash = OpenSSL::Digest::SHA256.new
        len = hash.digest_length
        return OpenSSL::KDF.pbkdf2_hmac(plaintext_password, salt: salt, iterations: iterations, length: len, hash: hash)
    end

    # returns a map of hashed password and the salt used
    def self.hash_password(plaintext_password)
        salt = OpenSSL::Random.random_bytes(16)
        value = self.calc_hash(plaintext_password, salt, NUM_ITERATIONS)
        return {"salt" => salt, "pwd_hash" => value}

    # checks if the hashed password and plaintext are same given the salt
    def self.check_hashed_password(plaintext_password, hashed_password, salt)
        return OpenSSL.fixed_length_secure_compare(
                    hashed_password,
                    self.calc_hash(plaintext_password, salt, NUM_ITERATIONS))

