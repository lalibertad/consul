class DeviseMailer < Devise::Mailer
  helper :application, :settings
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts={})
    unless record.hidden_at.nil?
      opts[:subject] = t('mailers.user_waiting.subject')
      opts[:template_name] = "user_waiting"
    end
    super
  end

  protected

  def devise_mail(record, action, opts = {})
    I18n.with_locale record.locale do
      super(record, action, opts)
    end
  end
end
