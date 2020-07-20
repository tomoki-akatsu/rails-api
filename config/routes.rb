Rails.application.routes.draw do
  namespace :api do
    # RestAPIのルーティングを簡単に書くための記法
    # 今回はcreateのみ使用したいのでonlyオプションで指定する
    resources :users, only: [:create]
    resources :session, only: [:create]
  end
end
