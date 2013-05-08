# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "Такси Zi < support@taxizi.ru >"

  def welcome_email(user)
   @user = user
   @url = "http://taxizi.ru/signin"
   email_with_name = "#{@user.name} <#{@user.email}>"
   mail(:to => email_with_name, :bcc => "vladislav.sychev@gmail.com", :subject => "Taxi Zi регистрация #{@user.name} на сайте прошла успешна")
  end

  def update_email(user)
   @user = user
   @url = "http://taxizi.ru/signin"
   email_with_name = "#{@user.name} <#{@user.email}>"
   mail(:to => email_with_name, :bcc => "vladislav.sychev@gmail.com", :subject => "TaxiZi обновление информации пользователя #{@user.name}")
  end

  def activate_contract_email(contract)
    @contract = contract
    @url = "http://taxizi.ru/contracts/#{@contract.id}"
    email_with_name = "#{@contract.contractor_name} <#{@contract.contractor_email}>"
    mail(to: email_with_name, bcc: "vladislav.sychev@gmail.com", subject: "Подтвердите свой заказ на Taxi Zi")
  end

  def new_offer_email(offer)
    @offer = offer
    @url = "http://taxizi.ru/offers/#{offer.id}"
    email_with_name = "#{@offer.contract.contractor_name} <#{@offer.contract.contractor_email}>"
    mail(to: email_with_name, bcc: "vladislav.sychev@gmail.com", subject: "Ваш заказ на Taxi Zi получил новое предложение")
  end

  def offer_taken_email(offer)
    @offer = offer
    email_with_name2 = "#{@offer.contract.contractor_name} <#{@offer.contract.contractor_email}>"
    email_with_name = "#{@offer.user.name} <#{@offer.user.email}>"
    mail(to: email_with_name, cc: email_with_name2, bcc: "vladislav.sychev@gmail.com", subject: "Предложение на заказ на сайте Taxi Zi принято")
  end

  def newpass_email(user)
    @user = user
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(to: email_with_name, bcc: "vladislav.sychev@gmail.com", subject: "Новый пароль #{@user.name} на сайте Taxi Zi.")
  end

  def posts_email(user)
    @user = user
    mail(to: "help@taxizi.ru", subject: "Post from Contact page")
  end

  def infoletter_email(contract)
    @contract = contract
    user_all = User.select(:email).where(:name => 'VLADISLAV SYCHEV').map(&:email)
    mail(bcc: user_all, subject: 'Новый заказ на Taxi Zi')
  end

end
