module Admin
  class AdministratorsController < Admin::BaseController

    crudify :administrator,
            :order => 'username ASC',
            :title_attribute => 'username',
            :sortable => false

    before_filter :load_available_plugins_and_roles, :only => [:new, :create, :edit, :update]

    def index
      search_all_administrators if searching?
      paginate_all_administrators

      render :partial => 'administrators' if request.xhr?
    end

    def new
      @administrator = Administrator.new
      @selected_plugin_names = []
    end

    def create
      @administrator = Administrator.new(params[:administrator])

      @selected_plugin_names = params[:administrator][:plugins] || []
      @selected_role_names = params[:administrator][:roles] || []

      if @administrator.save
        @administrator.plugins = @selected_plugin_names
        # if the user is a superuser and can assign roles according to this site's
        # settings then the roles are set with the POST data.
        unless current_administrator.has_role?(:superuser) and RefinerySetting.find_or_set(:superuser_can_assign_roles, false)
          @administrator.add_role(:refinery)
        else
          @administrator.roles = @selected_role_names.collect{|r| Role[r.downcase.to_sym]}
        end

        redirect_to(admin_administrators_url, :notice => t('created', :what => @administrator.username, :scope => 'refinery.crudify'))
      else
        render :action => 'new'
      end
    end

    def edit
      @administrator = Administrator.find_by_slug params[:id]
      @selected_plugin_names = @administrator.plugins.collect{|p| p.name}
    end

    def update
      # Store what the user selected.
      @selected_role_names = params[:administrator].delete(:roles) || []
      unless current_administrator.has_role?(:superuser) and RefinerySetting.find_or_set(:superuser_can_assign_roles, false)
        @selected_role_names = @administrator.roles.collect{|r| r.title}
      end
      @selected_plugin_names = params[:administrator][:plugins]

      # Prevent the current user from locking themselves out of the User manager
      if current_administrator.id == @administrator.id and (params[:administrator][:plugins].exclude?("refinery_administrators") || @selected_role_names.map(&:downcase).exclude?("refinery"))
        flash.now[:error] = t('cannot_remove_administrator_plugin_from_current_administrator', :scope => 'admin.administrators.update')
        render :action => "edit"
      else
        # Store the current plugins and roles for this user.
        @previously_selected_plugin_names = @administrator.plugins.collect{|p| p.name}
        @previously_selected_roles = @administrator.roles
        @administrator.roles = @selected_role_names.collect{|r| Role[r.downcase.to_sym]}
        if params[:administrator][:password].blank? and params[:administrator][:password_confirmation].blank?
          params[:administrator].delete(:password)
          params[:administrator].delete(:password_confirmation)
        end

        if @administrator.update_attributes(params[:administrator])
          redirect_to admin_administrators_url, :notice => t('updated', :what => @administrator.username, :scope => 'refinery.crudify')
        else
          @administrator.plugins = @previously_selected_plugin_names
          @administrator.roles = @previously_selected_roles
          @administrator.save
          render :action => 'edit'
        end
      end
    end

  protected

    def find_administrator
      @administrator = Administrator.find_by_slug(params[:id])
    end

    def load_available_plugins_and_roles
      @available_plugins = ::Refinery::Plugins.registered.in_menu.collect{|a|
        {:name => a.name, :title => a.title}
      }.sort_by {|a| a[:title]}

      @available_roles = Role.all
    end

  end
end

