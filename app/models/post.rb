# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  mind       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  
  # accepts_nested_attributes_for :photos
end
