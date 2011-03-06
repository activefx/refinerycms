module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def twitter
      debugger
    end

    # https://github.com/holden/devise-omniauth-example/blob/master/app/controllers/users/omniauth_callbacks_controller.rb
    # /users/auth/twitter/callback?oauth_token=R3MWDWxos24GFOcUDeeSkekVHYL56RVU83bVnv2PfYc&oauth_verifier=sHcYKkGHMvBgR9FO5mxneccFZnXfRIe3mBBTjTSbzs
    def method_missing(provider)
      debugger
      if !User.omniauth_providers.index(provider.to_sym).nil?
        omniauth = env["omniauth.auth"] # auth_hash
        debugger
        if current_user #or User.find_by_email(auth.recursive_find_by_key("email"))
          current_user.user_tokens.find_or_create_by(:provider => omniauth['provider'], :uid => omniauth['uid'])
          flash[:notice] = "Authentication successful"
          redirect_to edit_user_registration_path
        else
          user_token = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
          if user_token
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
            sign_in_and_redirect(:user, user_token.user)
            #sign_in_and_redirect(authentication.user, :event => :authentication)
            #sign_in_and_redirect(authentication, :event => :authentication)
          else
            #create a new user
            unless omniauth.recursive_find_by_key("email").blank?
              user = User.find_or_initialize_by(:email => omniauth.recursive_find_by_key("email"))
            else
              user = User.new
            end

            user.apply_omniauth(omniauth)

            if user.save
              user.confirm! if User.confirmable? && !user.email.blank?
              flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
              sign_in_and_redirect(:user, user)
              #sign_in_and_redirect(user, :event => :authentication)
            else
              session[:omniauth] = omniauth.except('extra')
              redirect_to new_user_registration_url
            end
          end
        end
      end
    end

    protected

  # redirect_to request.env['omniauth.origin'] || '/default'

  end
end

