module Admin
  class TokenAuthenticationsController < Admin::BaseController

    before_filter :find_actor

    def create
      @actor.authentication_token = @actor.class.authentication_token
      if @actor.save
        flash[:notice] = t('devise.token_authenticatable.successfully_generated_token')
      else
        flash[:alert] = t('devise.token_authenticatable.problem_generating_token')
      end
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug) )
    end

    def destroy
      @actor.authentication_token = nil
      if @actor.save
        flash[:notice] = t('devise.token_authenticatable.successfully_deleted_token')
      else
        flash[:alert] = t('devise.token_authenticatable.problem_deleting_token')
      end
      redirect_to( send("admin_#{@actor.type_for_path}_path", @actor.slug) )
    end

    protected

    def find_actor
      id_params = params[:user_id] || params[:administrator_id]
      @actor = Actor.find(id_params)
    end

  end
end

