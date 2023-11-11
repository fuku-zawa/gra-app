class CommentMailer < ApplicationMailer
  def new_comment(user, comment)
    @user = user
    @comment = comment
    mail to: user.email, subject: "【お知らせ】あなたに対するコメントがありました"
  end

end