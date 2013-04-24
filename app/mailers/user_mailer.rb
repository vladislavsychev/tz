class UserMailer < ActionMailer::Base
  default from: "support@taxizi.ru"

  def welcome_email(user)
   @user = user
   @url = "http://taxizi.ru/signin"
   mail(:to => user.email, :bcc => "vladislav.sychev@gmail.com", :subject => "Join confirmation")
  end

  def update_email(user)
   @user = user
   @url = "http://taxizi.ru/signin"
   mail(:to => user.email, :bcc => "vladislav.sychev@gmail.com", :subject => "Update user information on the TaxiZi")
  end
end
