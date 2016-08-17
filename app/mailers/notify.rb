class Notify < ActionMailer::Base
  default :from => "PokemanGoMingle <no-reply@techaffinity.com>"

  def send_email_change_notification(current_user)
    @current_user = current_user
    mail(:to=>@current_user.email, :subject =>"Email Change Notification", :reply_to => "no-reply@techaffinity.com")
  end

end
