# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 既存のデータをクリアしたい場合は残す（不要なら削除してください）
# Token.destroy_all

# 1. テスト用のユーザーを安全に用意する
user = User.find_or_initialize_by(email: "test@example.com")
if user.new_record?
  user.password = "password123"
  user.password_confirmation = "password123"
  user.name = "テストユーザー" # ← 行の先頭の「#」を消して有効化します！
  
  unless user.save
    puts "❌ ユーザーの作成に失敗しました: #{user.errors.full_messages}"
    exit
  end
end