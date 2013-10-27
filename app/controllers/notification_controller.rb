class NotificationController < ApplicationController

  @@client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])

  def simplify
    puts 'doing it!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    payment = Simplify::Payment.create({
      "token" => params[:simplifyToken],
      "amount" => 10,
      "currency" => "USD",
      "description" => "Someone purchased."
    })

    if payment['paymentStatus'] == 'APPROVED'
      render json: {simplify: true}
    else
      render json: {simplify: false, error: 'Simplify payment denied.'}
    end
  end

  def notify
    if ENV['send'] == 'do it!!!'
      email_status = NotifyMailer.notify_email(params[:email],  params[:name], params[:monitor_name], params[:original_content], params[:new_content]).deliver
      text_status = send_twilio_notification(params[:phone_number], params[:monitor_name])
      render json: { email: true, sms: true}
    else
      render json: {status: 'not sent because of config vars'}
    end
  end

  def send_twilio_notification(number, monitor_name)
    @@client.account.sms.messages.create(body: "ChangeNotifier alert on #{monitor_name}!  The content has changed.", to: number, from: ENV['TWILIO_NUMBER'])
  end
end
