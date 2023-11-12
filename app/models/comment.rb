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
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  # delegate :user, to: :post
  validates :content, presence: true

  # 追加されたコメントに「@ユーザ名」が含まれていると、その人にめーるを送る
  after_create :send_email
  private
  def send_email
    # all_user_name = []
    # all_user = User.all
    # all_user.each do |user|
    #   all_user_name.push(user.name)
    # end

    # all_user_name.each do |name|
    #   if (content.include?("@#{name}"))
    #     CommentMailer.new_comment(name,self).deliver_now
    #   end
    # end

    # plucでモデルからカラムを指定して配列で取得できる。
    all_user_info = User.pluck(:name, :email)
    all_user_info.each do |name, email|
        if (content.include?("@#{name}"))
          CommentMailer.new_comment(name,email,self).deliver_now
        end
      end

    # これでもいけそう
    # if all_user_name.any? { |name| content.include?("@#{name}") }
    # CommentMailer.new_comment(User.first, self).deliver_now
  end
  
end
