class AdministratorMailer < ActionMailer::Base

  def reset_notification(administrator, request)
    @administrator = administrator
    @url = edit_administrator_password_url( :host => request.host_with_port,
                                            :reset_password_token => @administrator.reset_password_token )

    domain = request.domain(RefinerySetting.find_or_set(:tld_length, 1))

    mail(:to => administrator.email,
         :subject => t('subject', :scope => 'administrator_mailer.reset_notification'),
         :from => "\"#{RefinerySetting[:site_name]}\" <no-reply@#{domain}>")
  end

protected

  def url_prefix(request)
    "#{request.protocol}#{request.host_with_port}"
  end
end

