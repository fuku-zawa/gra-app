# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_name, :user_avatar
  belongs_to :user

  def user_name
    # Comment.last.post.user.nameでnameを取得できる→postのユーザー名になっている
    object.user.name

  end

  def user_avatar
    object.user.avatar
  end

  

end
