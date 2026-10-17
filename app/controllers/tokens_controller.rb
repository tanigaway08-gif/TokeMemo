class TokensController < ApplicationController
  # このコントローラーの画面や機能を動かす前に、必ずユーザーがログインしているか確認
  # 未ログインならログイン画面に強制的に飛ばす
  before_action :authenticate_user!

  # ログインしているユーザーのトークン情報を呼び出して降順に並び替えてインスタンス変数@tokensに代入する
  def index
    @tokens = current_user.tokens.order(:code)

    # 1. キーワード検索（AND条件のままでOK）
    # 検索ボックスに何か入力されているかを確認
    # SQLを使って、キーワードを曖昧検索し、該当したものだけをインスタンス変数に上書き
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

    # 箱の中に1つでもチェックがあるならば、箱の中の条件を自動で.orで結合し、その結果該当したものをインスタンス変数に上書き
    # 配列とreduceを使うことで、いくつチェックされるかわからない時でも選ばれた数に応じて動的にOR条件を繋いでくれる
    if queries.any?
      @tokens = queries.reduce { |result, query| result.or(query) }
    end

    # ページネーション（ページ分割）の処理
    # リクエストされたページ番号（params[:page]）のデータを、1ページにつき最大10件ずつ取得して上書きする
    @tokens = @tokens.page(params[:page]).per(10)
  end

  # 今ログインしているユーザーのトークン情報からIDを使って検索し、該当したものをインスタンス変数に代入する
  def show
    @token = current_user.tokens.find(params[:id])
  end

  # 今ログインしているユーザーに紐づいた、新しいトークン用の「空のデータ（箱）」を作成し、フォームに渡す
  def new
    @token = current_user.tokens.build
  end

  # ユーザーがフォームに入力したデータを今ログインしているユーザーに紐づけてインスタンス変数に代入する
  # もし登録に成功したならフラッシュメッセージを出してトークン一覧画面に遷移する
  # 登録に失敗したらトークン新規登録画面のままにする
  def create
    @token = current_user.tokens.build(token_params)

    if @token.save
      redirect_to tokens_path, notice: "トークンを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 今ログインしているユーザーのトークン情報からIDを使って検索し、該当したものをインスタンス変数に代入する
  def edit
    @token = current_user.tokens.find(params[:id])
  end

  # 今ログインしているユーザーのトークン情報からIDを使って検索し、該当したものをインスタンス変数に代入する
  # もし更新に成功したならフラッシュメッセージを出して、トークン詳細画面に遷移して@tokenのデータを表示する
  # 更新に失敗したらトークン編集画面のままにする
  def update
    @token = current_user.tokens.find(params[:id])

    if @token.update(token_params)
      redirect_to token_path(@token), notice: "データを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 今ログインしているユーザーの トークン情報からIDを使って検索し、該当したものをインスタンス変数に代入する
  # そのインスタンスのデータを削除し、フラッシュメッセージを表示してトークン一覧画面に遷移する
  # 削除した後は強制的にGETメソッドを使う（see_otherによって、遷移エラーすることなく安全に遷移できる）
  def destroy
    @token = current_user.tokens.find(params[:id])
    @token.destroy
    redirect_to tokens_path, notice: "データを削除しました", status: :see_other
  end

  private

    # ストパロ、tokenモデルのうち記述したものだけをデータ登録できるようにする
    def token_params
      params.require(:token).permit(
        :code, :translation, :example, :memo,
        :lang_html, :lang_css, :lang_javascript, :lang_ruby, :lang_rails, :lang_other
      )
    end
end
