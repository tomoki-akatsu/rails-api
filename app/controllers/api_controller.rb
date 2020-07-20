class ApiController < ActionController::API
  # APIのControllerは、このAPIControllerを継承すること
  def authenticate
    render json: { errors: "Unauthorized" }, status: 401 unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.(request.headers)
  end
end
