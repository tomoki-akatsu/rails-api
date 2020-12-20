class Api::MicropostsController < ApiController
  # ログインしたユーザーのみ操作させたいため
  before_action :authenticate, only: [:create, :update, :destroy]

  def index
    # N+1問題を避けるためにincludesを使用する
    microposts = Micropost.includes(:user).order(created_at: :desc)
    # 対象がコレクションの場合はeach_serializerを使用する
    render json: microposts, each_serializer: MicropostSerializer
  end

  def create
    # current_userはUser.findの結果を返すので、
    # modelでhas_manyを指定しているmicropostsを呼び出せる
    # craeteは返り値としてtrue/falseを返却する
    # create!は作成したインスタンスを返却する
    # create!は正常に処理が行なわれなかった場合、例外を発生させる
    micropost = current_user.microposts.create!(micropost_params)
    render json: micropost, serializer: MicropostSerializer
  end

  def show
    # findは存在しない場合ActiveRecord::RecordNotFound例外が発生する。
    # 親コントローラーが例外をキャッチし、404例外処理を行う
    micropost = Micropost.find(params[:id])
    render json: micropost, serializer: MicropostSerializer
  end

  def update
    micropost = current_user.microposts.find(params[:id])
    micropost.update!(micropost_params)
    render json: micropost, serializer: MicropostSerializer
  end

  def destroy
    micropost = current_user.microposts.find(params[:id])
    micropost.destroy!
    render json: micropost, serializer: MicropostSerializer
  end

  private
    def micropost_params
      # 想定しているパラメータのみを受け取る
      params.require(:micropost).permit(:content)
    end
end
