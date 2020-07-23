class Api::SessionsController < ApiController
  def create
    user = User.find_by(email: session_params[:email])

    # emailを持つユーザーが存在し、passwordが一致してる場合のみjwtを返す
    if user&.authenticate(session_params[:password])
      # jwtを生成
      token = Jwt::TokenProvider.(user_id: user.id)
      render json: ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer).as_json.deep_merge(user: { token: token })
    else
      render json: { error: "メールアドレスまたはパスワードに誤りがあります。" }, status: 401
    end
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
