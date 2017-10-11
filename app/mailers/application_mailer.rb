class ApplicationMailer < ActionMailer::Base
  default from: 'admin@webrtc-on-rails.herokuapp.com'
  layout 'mailer'
end
