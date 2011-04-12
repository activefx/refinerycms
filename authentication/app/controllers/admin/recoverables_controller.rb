module Admin
  class RecoverablesController < Admin::BaseController

    before_filter :find_actor

    def create
      @actor.send(:generate_reset_password_token!)
      @actor.save
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.recoverable.successfully_generated_token') )
    end

    def update
      @actor.send(:generate_reset_password_token!)
      @actor.save
      @actor.send_reset_password_instructions
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.recoverable.successfully_resent_token',
                   :type => @actor._type.downcase) )
    end

    def destroy
      @actor.reset_password_token = nil
      @actor.save(:validate => false)
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.recoverable.successfully_deleted_token',
                   :type => @actor._type) )
    end

    protected

    def find_actor
      id_params = params[:user_id] || params[:administrator_id]
      @actor = Actor.find(id_params)
    end

  end
end

