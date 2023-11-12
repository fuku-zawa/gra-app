class ApplicationMailer < ActionMailer::Base
  # どこからメールが送られてくるか
  default from: 'from@example.com'
  # layouts/mailer.html.hamlとmailer.text.hamlを使う
  # htmlが一般的
  layout 'mailer'
end
