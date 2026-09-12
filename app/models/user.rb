class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :tokens, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    # has_secure_password
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 , maximum: 22 }
    validates :password_confirmation, presence: true
    
    def self.guest
        find_or_create_by!(email: 'guest@example.com') do |user|
        # ランダムなパスワードを一度変数に格納する
            random_password = SecureRandom.urlsafe_base64
            
            user.password = random_password
            # 【修正】password_confirmation にも同じ値を設定してバリデーションを通過させる
            user.password_confirmation = random_password 
            
            user.name = "ゲストユーザー"
        end
    end
end
