class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    # 1で作ったモデルのメソッドを呼び出す
    user = User.guest
    
    # Devise標準のログイン処理を実行
    sign_in user
    
    # ログイン後の遷移先を指定
    redirect_to tokens_path, status: :see_other, notice: 'ゲストユーザーとしてログインしました。'
  end
end