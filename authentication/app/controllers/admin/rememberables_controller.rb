module Admin
  class RememberablesController < Admin::BaseController

    before_filter :find_actor

    def destroy
      @actor.forget_me!
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug),
                   :notice => t('devise.rememberable.successfully_deleted_cookie') )
    end

    protected

    def find_actor
      id_params = params[:user_id] || params[:administrator_id]
      @actor = Actor.find(id_params)
    end

  end
end

