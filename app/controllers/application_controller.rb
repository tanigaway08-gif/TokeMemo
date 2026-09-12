class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  # 以下の3行を追加：Deviseに関する処理のときだけ、特別な許可設定を呼び出す
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    tokens_path # トークン一覧画面へ移動
  end
  
  protected

  # name（名前）のデータを受け取れるように許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  # Deviseのログアウト後のリダイレクト先を指定するメソッド
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # ログイン画面へ遷移
  end
end
