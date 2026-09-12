class Token < ApplicationRecord

    belongs_to :user
    
    validates :code, presence: true

        # カスタムバリデーションの呼び出し
    validate :must_have_at_least_one_language

    private

    # 「どれか1つはtrue（チェックあり）であること」を確認するメソッド
    def must_have_at_least_one_language
        unless lang_html || lang_css || lang_javascript || lang_ruby || lang_rails || lang_other
            # 1つもチェックがない場合、全体のエラー（:base）としてメッセージを追加する
            errors.add(:base, "関連言語を少なくとも1つ選択してください")
        end
    end
    
end
