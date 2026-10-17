class HomeController < ApplicationController
  # もしログイン状態であれば、このメソッドが実行された時にtokens_path（トークン一覧画面）へ遷移する
  def top
    if user_signed_in?
      redirect_to tokens_path
    end
  end
end
