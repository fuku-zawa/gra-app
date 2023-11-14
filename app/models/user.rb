# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy  
  has_many :likes, dependent: :destroy
  
  has_many :comments, dependent: :destroy

  # フォローしている関係（自分がfollowerになっている（自分のidがfolower_id））をfollowing_relationshipsとする。名前が変わっているのでclass_nameでもとのモデルを指定する
  # 外部キーがuser_idじゃないので、指定する（自分のidがfollower_idになっているデータを取得したいから外部キーはfollower_id）
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # フォローしている人（followings）をfollowing_relationshipsをまたいで取得したい。followingsは勝手につけたものでfollowingというモデルはないのでsourceを指定する
  has_many :followings, through: :following_relationships, source: :following

  # フォローされている関係
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  delegate :birthday, :introduction, :gender, :avatar, to: :profile, allow_nil: true
  delegate :mind, :photos, to: :posts, allow_nil: true

  def prepare_profile
    profile || build_profile
  end

  def display_name
    profile&.name || self.email.split("@")[0]
  end

  def has_liked(post)
    likes.exists?(post_id: post.id)
  end

  # フォロー機能
  def follow!(user)
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  # フォローを外す機能
  def unfollow!(user)
    user_id = get_user_id(user)
    # フォローしている人は見つかるはずなのでfind_by!
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  # フォローしているかを確認する
  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

  private
  # followとunfollowメソッドでしか使わないのでprivateにしておく
  def get_user_id(user)
    if user.is_a?(User)
      user.id
    else
      user
    end
  end

end
