class User < ActiveRecord::Base
  #バリデーション追加
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :profile, presence: true, length: { maximum: 50 }
  validates :location, presence: true, length: { maximum: 50 }
  validates :age , length: { maximum: 3 } , allow_blank: true ,  numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :birthday, length: { maximum: 4 } , allow_blank: true ,  numericality: { only_integer: true, greater_than_or_equal_to: 4 }
  
  #認証機能の追加
  has_secure_password
end
