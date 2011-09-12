class UserMailer < ActionMailer::Base

  default :from => "noreply@matharvard.ca"

  def change_password(user)
    @user = user
    mail(:to => @user.email, :subject => "[WAVES] Change your password")
  end

end
