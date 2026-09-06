class User < ApplicationRecord

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 , maximum: 20 }
    validates :password_confirmation, presence: true

end
