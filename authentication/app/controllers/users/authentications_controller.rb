#module Users
#  class AuthenticationsController < Application::Controller

#    before_filter :authenticate_user!

#    def index
#      @authentications = current_user.user_tokens
#    end

#    def destroy
#      @authentication = current_user.user_tokens.find(params[:id])
#      @authentication.destroy
#      flash[:notice] = "Successfully destroyed authentication."
#      redirect_to authentications_url
#    end

#  end
#end

