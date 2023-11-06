# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_name, :user_avatar
  belongs_to :user

  def user_name
    # Comment.last.post.user.nameでnameを取得できる
    object.post.user.name

  end

  def user_avatar
    object.post.user.profile.avatar
  end

  

end
