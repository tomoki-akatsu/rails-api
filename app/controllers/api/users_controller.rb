class Api::UsersController < ApiController
  def create
    user = User.new(user_params)
    if user.save
      # user_serializer.rb内のattributesで定義したカラムのみをJSONオブジェクト内に入れる
      render json: user, serializer: UserSerializer
    else
      error_message = { error: { messages: [ "Email has already been taken" ] } }
      render json: error_message, status: 422
    end
  end

  private
    def user_params
      # 想定しているパラメータのみを受け取る
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
