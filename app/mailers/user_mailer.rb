class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user, locale)
    @user = user
    
    I18n.with_locale(locale) do
      mail to: user.email
    end
  end
end
