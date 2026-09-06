class TokensController < ApplicationController
  def index
    # 1. まず全件取得（新しい順）
    @tokens = Token.all.order(created_at: :desc)

    # 2. キーワード検索（code カラムから検索）
    if params[:keyword].present?
      @tokens = @tokens.where("code LIKE ?", "%#{params[:keyword]}%")
    end

    # 3. 言語のチェックボックス検索（チェックが入っている場合は "1" が送られてきます）
    # 該当する言語が true になっているデータだけをさらに絞り込みます
    @tokens = @tokens.where(lang_html: true)       if params[:lang_html] == "1"
    @tokens = @tokens.where(lang_css: true)        if params[:lang_css] == "1"
    @tokens = @tokens.where(lang_javascript: true) if params[:lang_javascript] == "1"
    @tokens = @tokens.where(lang_ruby: true)       if params[:lang_ruby] == "1"
    @tokens = @tokens.where(lang_rails: true)      if params[:lang_rails] == "1"
    @tokens = @tokens.where(lang_other: true)      if params[:lang_other] == "1"
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

  def edit
    # 編集するデータを見つけてフォームに渡す
    @token = Token.find(params[:id])
  end

  def update
    # 更新するデータを見つける
    @token = Token.find(params[:id])
    
    # 新しいデータで上書き保存する
    if @token.update(token_params)
      # 成功したら詳細画面へ
      redirect_to token_path(@token), notice: "データを更新しました"
    else
      # 失敗したら編集画面を再表示
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # 1. 削除したいデータを見つける
    @token = Token.find(params[:id])
    
    # 2. データをデータベースから削除する
    @token.destroy
    
    # 3. 削除後、一覧画面に戻る
    redirect_to tokens_path, notice: "データを削除しました", status: :see_other
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
