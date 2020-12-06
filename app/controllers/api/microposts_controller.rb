class Api::MicropostsController < ApiController
  # ログインしたユーザーのみ操作させたいため
  before_action :authenticate, only: [:create]

  def create
    micropost = current_user.microposts.create!(micropost_params)
    if micropost.save
      render json: micropost, serializer: MicropostSerializer
    else
      error_message = { error: { messages: [ "Content can't be blank" ] } }
      render json: error_message, status: 422
    end
  end

  def show
  end

  def index
  end

  def update
  end

  def destroy
  end

  private
    def micropost_params
      # 想定しているパラメータのみを受け取る
      params.require(:micropost).permit(:content)
    end
end