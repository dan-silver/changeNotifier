class NotifyMailer < ActionMailer::Base
  default from: "ryan@endacott.me"

  def notify_email(email, name, website, old_content, new_content)
    mail(to: email, subject: "ChangeNotifier Alert on #{website}!", body: "Hi #{name}, \r\n\r\nThe content you were following: \"#{old_content}\" has changed to \"#{new_content}\"!\r\n\r\nWe hope you enjoy ChangeNotifier!\r\nSincerely,\r\n-The ChangeNotifier Team")
  end
end
