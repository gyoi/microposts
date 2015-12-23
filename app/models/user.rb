class User < ActiveRecord::Base
  #バリデーション追加
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :profile, presence: true, length: { maximum: 50 }, on: :update
  validates :location, presence: true, length: { maximum: 50 }, on: :update
  validates :age , length: { maximum: 3 } , allow_blank: true ,  numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :birthday, length: { maximum: 4 } , allow_blank: true ,  numericality: { only_integer: true, greater_than_or_equal_to: 4 }
  
  #認証機能の追加
  has_secure_password
  
  #micropost機能との連携。各ユーザは複数投稿を持てる。
  has_many :microposts
  
  #特定ユーザがフォローしているユーザのリスト列挙用
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed

  #特定ユーザがフォローされているユーザのリスト列挙用
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower

  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか確認する
  def following?(other_user)
    following_users.include?(other_user)
  end
end
