class TokensController < ApplicationController

  before_action :authenticate_user! 

  def index
    @tokens = current_user.tokens.order(created_at: :desc)

    # 1. キーワード検索（AND条件のままでOK）
    if params[:keyword].present?
      @tokens = @tokens.where("code LIKE ?", "%#{params[:keyword]}%")
    end

    # 2. 言語のチェックボックス検索（OR条件に変更）
    # 選ばれた条件をいったん配列（queries）にまとめる
    queries = []
    queries << @tokens.where(lang_html: true)       if params[:lang_html] == "1"
    queries << @tokens.where(lang_css: true)        if params[:lang_css] == "1"
    queries << @tokens.where(lang_javascript: true) if params[:lang_javascript] == "1"
    queries << @tokens.where(lang_ruby: true)       if params[:lang_ruby] == "1"
    queries << @tokens.where(lang_rails: true)      if params[:lang_rails] == "1"
    queries << @tokens.where(lang_other: true)      if params[:lang_other] == "1"

    # チェックが1つ以上ある場合だけ、配列の中身を「or」で繋ぎ合わせる
    if queries.any?
      @tokens = queries.reduce { |result, query| result.or(query) }
    end

    @tokens = @tokens.page(params[:page]).per(10)

  end

  def show
    # 【修正】自分のデータの中から探す
    @token = current_user.tokens.find(params[:id])
  end
  
  def new
    # 【修正】自分のデータとして空のインスタンスを作成（new の代わりに build をよく使います）
    @token = current_user.tokens.build
  end

  def create
    # 【修正】自分のデータとしてパラメーターを受け取る
    @token = current_user.tokens.build(token_params)

    if @token.save
      redirect_to tokens_path, notice: "トークンを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 【修正】自分のデータの中から探す
    @token = current_user.tokens.find(params[:id])
  end

  def update
    # 【修正】自分のデータの中から探す
    @token = current_user.tokens.find(params[:id])
    
    if @token.update(token_params)
      redirect_to token_path(@token), notice: "データを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # 【修正】自分のデータの中から探す
    @token = current_user.tokens.find(params[:id])
    @token.destroy
    redirect_to tokens_path, notice: "データを削除しました", status: :see_other
  end

  private

    def token_params
      params.require(:token).permit(
        :code, :translation, :example, :memo,
        :lang_html, :lang_css, :lang_javascript, :lang_ruby, :lang_rails, :lang_other
      )
    end
end