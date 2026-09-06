class SessionsController < ApplicationController
  def create
    email = params[:email]&.downcase 
    user = User.find_by(email: email)

    if user && user.authenticate(params[:password])
      # log_in user を以下の1行に書き換える
      session[:user_id] = user.id
      
      redirect_to tokens_path
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています'
      render 'new', status: :unprocessable_entity
    end
  end
end