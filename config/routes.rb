Rails.application.routes.draw do
  root "home#index"
  namespace :api do
    # RestAPIのルーティングを簡単に書くための記法
    # 今回はcreateのみ使用したいのでonlyオプションで指定する
    resources :users, only: [:create]
    resource :session, only: [:create]
  end
end
