class ApplicationMailer < ActionMailer::Base
  default from: Setting.email_form
  default charset: 'utf-8'
  default content_type: 'text/html'

  layout 'mailer'
end
