class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  # いいね機能
  has_many :favorites, dependent: :destroy

  # コメント機能
  has_many :book_comments, dependent: :destroy

  #フォロー・フォロワー機能
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  def create(user_id)
    follower.create(followed_id: user_id)
  end
  def destroy(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    following_user.include?(user)
  end


  attachment :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

end
