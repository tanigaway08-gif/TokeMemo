class Users::SessionsController < Devise::SessionsController
  # このメソッドが実行されたら、変数userにUser.guest（ゲストユーザー用アカウント情報）の値を代入する
  # userに入れた値を使って、devise標準のログイン処理を実行する
  # ログインした後にtokens_path（トークン一覧画面）に遷移して、フラッシュメッセージを出す
  # ログインした後は、他のページをGETで見てねという合図のためsee_otherをつける
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to tokens_path, status: :see_other, notice: "ゲストユーザーとしてログインしました。"
  end
end
