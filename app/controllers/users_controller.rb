class UsersController < ApplicationController
    # データベースに保存される前の新しいUserモデルのインスタンスを作成して、インスタン変数に代入
    def new
        @user = User.new
    end

    # フォームに入力されたデータをインスタンス変数に代入
    # もし登録が成功したなら、ログイン画面に遷移してフラッシュメッセージを出す
    # 失敗したなら、新規登録画面のままにする
    def create
        @user = User.new(user_params)
        if @user.save
        redirect_to login_path, notice: "ユーザーが正常に作成されました。"
        else
        render :new, status: :unprocessable_entity
        end
    end

    # ユーザーIDで検索してインスタンス変数に代入する（閲覧用）
    def show
        @user = User.find(params[:id])
    end

    # 【今後実装予定】
    # ユーザーIDで検索してインスタンス変数に代入する（編集用）
    def edit
        @user = User.find(params[:id])
    end

    # 【今後実装予定】
    # ユーザーIDで検索してインスタンス変数に代入する（更新用）
    # もし更新に成功したなら、そのユーザーの詳細画面（まだ未実装）に遷移してフラッシュメッセージを出す
    # 失敗したなら、編集画面のままにする
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to @user, notice: "ユーザー情報が正常に更新されました。"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # 【今後実装予定】
    # ユーザーIDで検索してインスタンス変数に代入する（削除用）
    # ユーザーデータを削除後はホーム画面に遷移して、フラッシュメッセージを出す
    # 削除した後は強制的にGETメソッドを使う（see_otherによって、遷移エラーすることなく安全に遷移できる）
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to root_path, notice: "ユーザーが正常に削除されました。", status: :see_other
    end

    private

    # ストパロ、userモデルのうち記述したものだけをデータ登録できるようにする
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
