# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "Такси Zi < support@taxizi.ru >"

  def welcome_email(user)
   @user = user
   @url = "http://taxizi.ru/signin"
   email_with_name = "#{@user.name} <#{@user.email}>"
   mail(:to => email_with_name, :bcc => "taxiziru@yandex.ru", :subject => "Taxi Zi регистрация #{@user.name} на сайте прошла успешна")
  end

  def update_email(user)
   @user = user
   @url = "http://taxizi.ru/signin"
   email_with_name = "#{@user.name} <#{@user.email}>"
   mail(:to => email_with_name, :subject => "TaxiZi обновление информации пользователя #{@user.name}")
  end

  def activate_contract_email(contract)
    @contract = contract
    @url = "http://taxizi.ru/contracts/#{@contract.id}"
    email_with_name = "#{@contract.contractor_name} <#{@contract.contractor_email}>"
    mail(to: email_with_name, bcc: "taxiziru@yandex.ru", subject: "Подтвердите свой заказ #{@contract.t_car} на Taxi Zi")
  end

  def new_offer_email(offer)
    @offer = offer
    @url = "http://taxizi.ru/offers/#{@offer.id}"
    email_with_name = "#{@offer.contract.contractor_name} <#{@offer.contract.contractor_email}>"
    mail(to: email_with_name, bcc: "taxiziru@yandex.ru", subject: "Ваш заказ на Taxi Zi получил новое предложение")
  end

  def offer_taken_email(offer)
    @offer = offer
    email_with_name2 = "#{@offer.contract.contractor_name} <#{@offer.contract.contractor_email}>"
    email_with_name = "#{@offer.user.name} <#{@offer.user.email}>"
    mail(to: email_with_name, cc: email_with_name2, bcc: "taxiziru@yandex.ru", subject: "Предложение на заказ на сайте Taxi Zi принято")
  end

  def newpass_email(user)
    @user = user
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(to: email_with_name, bcc: "taxiziru@yandex.ru", subject: "Новый пароль #{@user.name} на сайте Taxi Zi.")
  end

  def posts_email(user)
    @user = user
    mail(to: "taxiziru@yandex.ru", subject: "Post from Contact or Help page")
  end

  def infoletter_email(contract)
    @contract = contract
    @uawe_all = Array.new
    @user_all = User.select(:email).where(:name => 'VLADISLAV SYCHEV').map(&:email)
    mail(to: "taxiziru@yandex.ru", bcc: @user_all, subject: "Открытый заказ #{@contract.t_car} на Taxi Zi")
  end

end
