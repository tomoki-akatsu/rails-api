module Jwt::UserAuthenticator
  extend self

  def call(request_headers)
    @request_headers = request_headers

    begin
      payload, _header = Jwt::TokenDecryptor.call(token)
      User.find(payload["user_id"])
    rescue => e
      # log error here
      nil
    end
  end

  def token
    @request_headers["Authorization"].split(" ").last
  end
end
