class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  mount_uploader :avatar, AvatarUploader
  validate  :avatar_size

  private
  
    def avatar_size
        if avatar.size > 5.megabytes
          errors.add(:picture, "should be less than 5MB")
        end
    end
end
