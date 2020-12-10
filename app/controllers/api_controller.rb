class ApiController < ActionController::API
  # APIのControllerは、このAPIControllerを継承すること
  def authenticate
    render json: { error: { messages: ["Unauthorized"] } }, status: 401 unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.call(request.headers)
  end
end
