class AdministratorPasswordsController < ::Devise::PasswordsController
  layout 'login'

  # Rather than overriding devise, it seems better to just apply the notice here.
  after_filter :give_notice, :only => [:update]
  def give_notice
    unless %w(notice error alert).include?(flash.keys.map(&:to_s)) or @administrator.errors.any?
      flash[:notice] = t('successful', :scope => 'administrators.reset', :email => @administrator.email)
    end
  end
  protected :give_notice

  # GET /registrations/password/edit?reset_password_token=abcdef
  def edit
    if params[:reset_password_token] and (@administrator = Administrator.find_by_reset_password_token(params[:reset_password_token])).present?
      render_with_scope :edit
    else
      redirect_to(new_administrator_password_url, :flash => ({
        :error => t('code_invalid', :scope => 'administrators.reset')
      }))
    end
  end

  # POST /registrations/password
  def create
    if params[:administrator].present? and (email = params[:administrator][:email]).present? and
       (administrator = Administrator.find_by_email(email)).present?

      # Call devise reset function.
      administrator.send(:generate_reset_password_token!)
      administrator.save
      AdministratorMailer.reset_notification(administrator, request).deliver
      redirect_to new_administrator_session_path, :notice => t('email_reset_sent', :scope => 'administrators.forgot') and return
    else
      @administrator = Administrator.new(params[:administrator])
      flash.now[:error] = if (email = params[:administrator][:email]).blank?
        t('blank_email', :scope => 'administrators.forgot')
      else
        t('email_not_associated_with_account_html', :email => email, :scope => 'administrators.forgot').html_safe
      end
      render_with_scope :new
    end
  end
end

