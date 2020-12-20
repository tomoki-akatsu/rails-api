module Jwt::TokenDecryptor
  extend self

  def call(token)
    decrypt(token)
  end

  private
    def decrypt(token)
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      raise InvalidTokenError
    end
end

class InvalidTokenError < StandardError; end
