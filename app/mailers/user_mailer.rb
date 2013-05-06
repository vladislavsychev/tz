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

  def activate_contract_email(contract)
    @contract = contract
    @url = "http://taxizi.ru/contracts/#{@contract.id}"
    mail(to: contract.contractor_email, bcc: "vladislav.sychev@gmail.com", subject: "Activation Code TaxiZi")
  end

  def new_offer_email(offer)
    @offer = offer
    @url = "http://taxizi.ru/offers/#{offer.id}"
    mail(to: offer.contract.contractor_email, bcc: "vladislav.sychev@gmail.com", subject: "New offer for your order TAXIZI")
  end

  def offer_taken_email(offer)
    @offer = offer
    mail(to: offer.user.email, cc: offer.contract.contractor_email, bcc: "vladislav.sychev@gmail.com", subject: "Taken offer. TaxaZi. Contacts")
  end

  def newpass_email(user)
    @user = user
    mail(to: @user.email, bcc: "vladislav.sychev@gmail.com", subject: "New password. Tax iZi.")
  end

  def posts_email(user)
    @user = user
    mail(to: "taxiziru@yandex.ru", subject: "Post from Contact page")
  end

  def infoletter_email(contract)
    @contract.contract
    user = User.select(:email).all
    mail(to: user, subject: 'new order Taxi Zi')
  end

end
