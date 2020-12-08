class Api::MicropostsController < ApiController
  # ログインしたユーザーのみ操作させたいため
  before_action :authenticate, only: [:create]

  def index
    # N+1問題を避けるためにincludesを使用する
    microposts = Micropost.includes(:user).order(created_at: :desc)
    # 対象がコレクションの場合はeach_serializerを使用する
    render json: microposts, each_serializer: MicropostSerializer
  end

  def create
    # current_userはUser.findの結果を返すので、
    # modelでhas_manyを指定しているmicropostsを呼び出せる
    micropost = current_user.microposts.create!(micropost_params)
    if micropost.save
      render json: micropost, serializer: MicropostSerializer
    else
      error_message = { error: { messages: [ "Content can't be blank" ] } }
      render json: error_message, status: 422
    end
  end

  def show
    # findの場合だと存在しない場合ActiveRecord::RecordNotFound例外が発生する。
    micropost = Micropost.find_by(id: params[:id])
    if micropost
      render json: micropost, serializer: MicropostSerializer
    else
      error_message = { error: { messages: [ "404 Not found" ] } }
      render json: error_message, status: 404
    end
  end

  def update
    micropost = current_user.microposts.find(params[:id])
    micropost.update!(micropost_params)
    render json: micropost, serializer: MicropostSerializer
  end

  def destroy
    micropost = current_user.microposts.find(params[:id])
    micropost.destroy!()
    render json: micropost, serializer: MicropostSerializer
  end

  private
    def micropost_params
      # 想定しているパラメータのみを受け取る
      params.require(:micropost).permit(:content)
    end
end
