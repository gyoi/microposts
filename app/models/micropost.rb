class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  #画像アップロード用
  mount_uploader :picture, PictureUploader
  validate  :picture_size

end

  # アップロード画像のサイズを検証する
  def picture_size
    if picture.size > 1.megabytes
      errors.add(:picture, "1MBまでですよ")
    end
  end
