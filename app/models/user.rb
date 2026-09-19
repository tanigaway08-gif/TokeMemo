class User < ApplicationRecord

    # トークンテーブルはユーザーテーブル1レコードに対して複数つくことを示す（1対多の関係） 
    # ユーザー情報を削除した時には、それに関連するトークン情報も削除する
    has_many :tokens, dependent: :destroy

    # このモデルで使用するDeviseの機能（モジュール）を設定
    # （パスワード認証、新規登録、パスワード復旧、ログイン保持、標準バリデーション）
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    
    # バリデーションを設定
    # 名前、email、パスワード、パスワード確認は必須入力
    # emailはすでに登録していないものを要求、パスワードは6文字以上22文字以内を要求
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 , maximum: 22 }
    validates :password_confirmation, presence: true
    
    # ゲストユーザーを作成するメソッド作成
    # emailは指定したものを使用、パスワードはランダムに作成する
    # 指定のメールアドレスがいない場合はこの処理を実行する
    # !をつけることで、バリデーションエラーで失敗した時にエラーを検知できる
    def self.guest
        find_or_create_by!(email: 'guest@example.com') do |user|
            # ランダムなパスワードを一度変数に格納して、それをユーザーテーブルのパスワードに代入
            # password_confirmation にも同じ値を設定してバリデーションを通過させる
            # 変数に入れないとパスワードとパスワード確認でそれぞれランダム文字列が生成されて一致しなくなる
            # 名前はゲストユーザーとして登録
            random_password = SecureRandom.urlsafe_base64
            user.password = random_password
            user.password_confirmation = random_password            
            user.name = "ゲストユーザー"
        end
    end
end
