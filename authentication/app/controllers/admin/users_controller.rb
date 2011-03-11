module Admin
  class UsersController < Admin::BaseController

    crudify :user,
            :order => 'username ASC',
            :title_attribute => 'username',
            :xhr_paging => true

    before_filter :load_available_plugins_and_roles, :only => [:new, :create, :edit, :update]

    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      @selected_role_names = params[:user][:roles] || []

      if @user.save
        @user.confirm!

        # if the user is a superuser and can assign roles according to this site's
        # settings then the roles are set with the POST data.
        unless current_administrator.has_role?(:superuser) and RefinerySetting.find_or_set(:superuser_can_assign_roles, false)
          @user.roles = @selected_role_names.collect{|r| Role[r.downcase.to_sym]}
        end

        redirect_to(admin_users_url, :notice => t('created', :what => @user.username, :scope => 'refinery.crudify'))
      else

        render :action => 'new'
      end
    end

    def edit
      @user = User.find_by_slug params[:id]
    end

    def update
      # Store what the user selected.
      @selected_role_names = params[:user].delete(:roles) || []
      unless current_administrator.has_role?(:superuser) and RefinerySetting.find_or_set(:superuser_can_assign_roles, false)
        @selected_role_names = @user.roles.collect{|r| r.title}
      end

      @previously_selected_roles = @user.roles
      @user.roles = @selected_role_names.collect{|r| Role[r.downcase.to_sym]}
      if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      if @user.update_attributes(params[:user])
        redirect_to admin_users_url, :notice => t('updated', :what => @user.username, :scope => 'refinery.crudify')
      else
        @user.roles = @previously_selected_roles
        @user.save
        render :action => 'edit'
      end

    end

  protected

    def find_user
      @user = User.find_by_slug(params[:id])
    end

    def load_available_plugins_and_roles
      @available_roles = [ Role[:subscriber] ]
    end

  end
end

