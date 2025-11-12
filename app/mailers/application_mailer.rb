# app/mailers/application_mailer.rb

# used to send emails from the application
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
