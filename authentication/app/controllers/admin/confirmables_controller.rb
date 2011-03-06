module Admin
  class ConfirmablesController < Admin::BaseController

    before_filter :find_actor

    def create
      @actor.confirm!
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.confirmable.confirmed', :type => @actor._type) )
    end

    def update
      @actor.send_confirmation_instructions
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.confirmable.successfully_resent' ) )
    end

    protected

    def find_actor
      id_params = params[:user_id] || params[:administrator_id]
      @actor = Actor.find(id_params)
    end

  end
end

