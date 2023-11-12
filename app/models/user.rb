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


end
