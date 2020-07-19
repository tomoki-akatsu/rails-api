class Api::UsersController < ApiController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, serializer: UserSerializer
    else
      error_message = { error: { messages: [ "メールアドレスまたはパスワードに誤りがあります。" ] } }
      render json: error_message
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
