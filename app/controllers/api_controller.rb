class ApiController < ActionController::Base
  # APIのControllerは、このAPIControllerを継承すること

  # Railsは自動的にCSRF対策のためのtoken検証を行ってくれるが、
  # APIの場合はステートレスなため不要であり、外部からAPIを利用したいため
  # CSRF検証に失敗した場合はセッションを空にする指定を行う(初期値の場合は例外を発生させる)
  protect_from_forgery with: :null_session

  # 独自エラークラスを定義
  class AuthenticationError < StandardError; end

  # 指定したexceptionが発生した場合の動作を指定
  # このコントローラーを継承した各コントローラの例外をここでキャッチする。

  # DBにデータが存在しない場合
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # modelで定義したvalidateに失敗した場合
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  # 認証情報がない状態で認証情報が必要な処理をしようとした場合
  rescue_from AuthenticationError, with: :not_authenticated

  def authenticate
    raise AuthenticationError unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.call(request.headers)
  end

  private
    def render_404(exception)
      render json: { error: { messages: exception.message } }, status: :not_found
    end

    def render_422(exception)
      render json: { error: { messages: exception.record.errors.full_messages } }, status: :unprocessable_entity
    end

    def not_authenticated
      render json: { error: { messages: ["ログインしてください"] } }, status: :unauthorized
    end
end
