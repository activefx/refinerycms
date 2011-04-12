class AuthenticationsController < ApplicationController

  before_filter :authenticate_user!

  #def index
  #  @authentications = current_user.user_tokens
  #end

  def destroy
    @authentication = current_user.user_tokens.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed #{@authentication.provider} authentication."
    redirect_to edit_user_registration_path
  end

end

