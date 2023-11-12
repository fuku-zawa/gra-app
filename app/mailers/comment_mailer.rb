class CommentMailer < ApplicationMailer
  def new_comment(name, email, comment)
    @name = name
    @email = email
    @comment = comment
    mail to: email, subject: "【お知らせ】あなたに対するコメントがありました"
  end

end