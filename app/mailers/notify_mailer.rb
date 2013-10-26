class NotifyMailer < ActionMailer::Base
  default from: "ryan@endacott.me"

  def notify_email(email, name, website, old_content, new_content)
    mail(to: email, subject: "#{website} has changed!", body: "Hi #{name}, \r\n#{old_content} has changed to #{new_content}!\r\n We hope you enjoy ChangeNotifier!")
  end
end
