class NotificationController < ApplicationController

  @@client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])

  def notify
    if ENV['send'] == 'do it!!!'
      email_status = NotifyMailer.notify_email(params[:email],  params[:name], params[:website], params[:original_content], params[:new_content]).deliver
      text_status = send_twilio_notification(params[:phone_number], params[:website])
      render json: { email: true, sms: true}
    else
      render json: {status: 'not sent because of config vars'}
    end
  end

  def send_twilio_notification(number, url)
    @@client.account.sms.messages.create(body: "ChangeNotifier alert on #{url}!  The content has changed.", to: number, from: ENV['TWILIO_NUMBER'])
  end
end
