class AdministratorRegistrationsController < ::Devise::RegistrationsController

  # Protect these actions behind an admin login
  before_filter :redirect?, :only => [:new, :create]

  layout 'login'

  def new
    @administrator = Administrator.new
  end

  # This method should only be used to create the first Refinery user.
  def create
    @selected_plugin_titles = params[:administrator][:plugins] || []
    params[:administrator].delete(:plugins)
    @administrator = Administrator.new(params[:administrator])

    @administrator.save if @administrator.valid?

    if @administrator.errors.empty?
      @administrator.add_role(:refinery)
      @administrator.plugins = @selected_plugin_titles
      @administrator.save
      if Role[:refinery].actors.where(:_type => 'Administrator').count == 1
        # this is the superuser if this user is the only user.
        @administrator.add_role(:superuser)
        @administrator.confirm! if Administrator.confirmable?
        @administrator.save

        # set this user as the recipient of inquiry notifications, if we're using that engine.
        if defined?(InquirySetting) and
          (notification_recipients = InquirySetting.find_or_create_by_name("Notification Recipients")).present?
          notification_recipients.update_attributes({
            :value => @administrator.email,
            :destroyable => false
          })
        end
      end

      flash[:message] = "<h2>#{t('welcome', :scope => 'administrators.create', :who => @administrator.username).gsub(/\.$/, '')}.</h2>".html_safe

      site_name_setting = RefinerySetting.find_or_create_by_name('site_name', :value => "Company Name")
      if site_name_setting.value.to_s =~ /^(|Company\ Name)$/ or Role[:refinery].actors.where(:_type => 'Administrator').count == 1
        flash[:message] << "<p>#{t('setup_website_name_html', :scope => 'administrators',
                                   :link => edit_admin_refinery_setting_url(site_name_setting, :dialog => true),
                                   :title => t('edit', :scope => 'admin.refinery_settings'))}</p>".html_safe
      end
      sign_in(@administrator)
      redirect_back_or_default(admin_root_url)
    else
      render :action => 'new'
    end
  end

protected

  def redirect?
    if refinery_user?
      redirect_to admin_administrators_url
    elsif refinery_administrators_exist?
      redirect_to new_administrator_session_path
    end
  end

  def refinery_administrators_exist?
    Role[:refinery].actors.where(:_type => 'Administrator').any?
  end

end

