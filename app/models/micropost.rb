class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :likes
  has_many :favs, through: :likes, source: :user
  
  def liking(other_user)
    self.likes.find_or_create_by(user_id: other_user.id)
  end
    
  def unliking(other_user)
    like = self.likes.find_by(user_id: other_user.id)
    like.destroy if like
  end
    
  def liked?(other_user)
    self.favs.include?(other_user)
  end
  
end
