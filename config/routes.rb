Rails.application.routes.draw do
  # ホーム画面へのルーティング
  root "home#top"
  get "home/top"

  # Userの認証用ルーティング（ログイン・ログアウト処理はカスタムコントローラーを使用）
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # ゲストユーザーがログインする場合のルーティング
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in', as: :users_guest_sign_in
  end

  # アプリケーションの稼働状況を確認するヘルスチェック用エンドポイント
  get "up" => "rails/health#show", as: :rails_health_check

  # ユーザープロフィール詳細画面のみ定義（その他はDeviseに任せる）
  resources :users, only: %i[show]

  # トークン関連のルーティングを一括定義
  resources :tokens
end