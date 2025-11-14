# app/mailers/contact_mailer.rb
class ContactMailer < ApplicationMailer
  default to: '7657721@gmail.com'

  def notify_admin
    @name = params[:name]
    @message = params[:message]
    @lang = params[:lang]
    mail(from: params[:email], subject: "Новое сообщение с сайта (#{@lang.upcase})")
  end
end
