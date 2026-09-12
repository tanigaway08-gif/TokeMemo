class HomeController < ApplicationController
  def top
  # ▼ 追加：ログイン済みの場合はトークン一覧画面にリダイレクトする ▼
    if user_signed_in?
      redirect_to tokens_path
    end
  end
end
