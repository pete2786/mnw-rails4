# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  helper :application
  default from: "no-reply@cleverweather.com"
  layout 'email_template'
end
