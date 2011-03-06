module Admin
  class LockablesController < Admin::BaseController

    before_filter :find_actor

    def create
      @actor.unlock_access!
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.lockable.successfully_unlocked', :type => @actor._type) )
    end

    def update
      @actor.unlock_token = @actor.class.unlock_token if @actor.unlock_token.blank?
      @actor.save(:validate => false)
      @actor.send_unlock_instructions
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.lockable.resent_instructions') )
    end

    def destroy
      @actor.lock_access!
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.lockable.account_locked', :type => @actor._type.downcase) )
    end

    protected

    def find_actor
      id_params = params[:user_id] || params[:administrator_id]
      @actor = Actor.find(id_params)
    end

  end
end

