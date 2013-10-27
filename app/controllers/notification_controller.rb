class NotificationController < ApplicationController

  @@client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])

  def notify
    if ENV['send'] == 'do it!!!'
      email_status = NotifyMailer.notify_email(params[:email],  params[:name], params[:website], params[:original_content], params[:new_content]).deliver
      text_status = send_twilio_notification(params[:phone_number])
    end
    render json: { email: true, sms: true}
  end

  def send_twilio_notification(number = '+14179880783')
    @@client.account.sms.messages.create(body: 'Temporary body', to: number, from: ENV['TWILIO_NUMBER'])
  end
end
