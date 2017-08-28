class DiggleMailer < Devise::Mailer   
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Diggle"
    opts[:subject] = 'Confirm your email account'
    opts[:from] = 'Diggle <confirm.diggle@example.com>'
    opts[:reply_to] = 'Diggle <no-reply.diggle@example.com>'
    super
  end
end
