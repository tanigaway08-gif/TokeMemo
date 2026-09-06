class TokensController < ApplicationController
  def index
    # 基本は全件取得（新しい順）
    @tokens = Token.all.order(created_at: :desc)

    # キーワード検索が送信された場合の絞り込み処理
    if params[:keyword].present?
      @tokens = @tokens.where("title LIKE ?", "%#{params[:keyword]}%")
    end
    
    # ※チェックボックス（言語指定）の検索処理も必要に応じてここに追加します
  end

  def show
    # URLのID（/tokens/1 など）から対象のデータを1件探す
    @token = Token.find(params[:id])

  end
  
  def new
    # フォームに入力するための空のインスタンスを作成
    @token = Token.new
  end

  def create
    @token = Token.new(token_params)

    if @token.save
      # 保存に成功したら一覧画面へ移動
      redirect_to tokens_path, notice: "トークンを登録しました"
    else
      # 失敗したら入力画面を再表示
      render :new, status: :unprocessable_entity
    end
  end

  private

    # セキュリティのためのストロングパラメーター
    def token_params
      params.require(:token).permit(
        :code, :translation, :example, :memo,
        :lang_html, :lang_css, :lang_javascript, :lang_ruby, :lang_rails, :lang_other
      )
    end
  
end
