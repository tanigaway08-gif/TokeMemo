class Token < ApplicationRecord
    # tokenモデルはuserモデルに所属する
    belongs_to :user

    # バリデーションを設定、コード名は入力必須にする
    validates :code, presence: true

    # カスタムバリデーション（自作のバリデーション）の呼び出し
    # 言語選択は1つ以上のチェックを必須とする
    validate :must_have_at_least_one_language

    private

    # どれか1つはtrue（チェックあり）であることを確認するメソッド
    def must_have_at_least_one_language
        unless lang_html || lang_css || lang_javascript || lang_ruby || lang_rails || lang_other
            # 1つもチェックがない場合、全体のエラー（:base）としてメッセージを追加する
            errors.add(:base, "関連言語を少なくとも1つ選択してください")
        end
    end
end
