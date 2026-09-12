class SessionsController < ApplicationController

  def create
    email = params[:email]&.downcase 
    user = User.find_by(email: email)

    if user && user.valid_password?(params[:password])
      # 【修正】自作のsessionではなく、Deviseのログインメソッドを使う
      sign_in(user)
      
      redirect_to tokens_path, status: :see_other, notice: 'ログインしました'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    # 【修正】自作のsession削除ではなく、Deviseのログアウトメソッドを使う
    sign_out(current_user)
    
    redirect_to new_user_session_path, status: :see_other, notice: 'ログアウトしました'
  end

end
