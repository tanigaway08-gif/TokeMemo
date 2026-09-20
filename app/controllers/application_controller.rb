class ApplicationController < ActionController::Base
  # 古いブラウザからのアクセスをブロックして、新しい（モダンな）ブラウザだけを許可する
  allow_browser versions: :modern

  # もしdeviseで設定したコントローラーを使用するときは、先にこのメソッドを実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # このメソッドを実行したらトークン一覧画面へ移動する
  # deviseはログインが成功した後に自動的にこのメソッドを呼び出す
  # 次どこに行けばいい？と聞いてくるので指定する
  def after_sign_in_path_for(resource)
    tokens_path
  end

  protected

  # sign_up（新規登録）の時だけ、name（名前）のデータを受け取れるように許可する
  # deviseは最初からストパロが設定されていて、email,password,password_confirmation以外は受け取れない
  # そのため:nameの許可が必要となる
  # ちなみに、deviseはApplicationControllerの子コントローラーなのでdeviseから呼べるようにprotectedにする
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end

  private

  # Deviseのログアウト後のリダイレクト先を指定するメソッド
  # ログアウトした後の遷移先を勝手に変えられないようにprivateに記述する
  def after_sign_out_path_for(resource_or_scope)
    root_path # home画面へ遷移
  end
end
