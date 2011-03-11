module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    User.omniauth_providers.each do |provider|
      class_eval("def #{provider}; create; end")
    end

    # https://github.com/holden/devise-omniauth-example/blob/master/app/controllers/users/omniauth_callbacks_controller.rb
    # /users/auth/twitter/callback?oauth_token=R3MWDWxos24GFOcUDeeSkekVHYL56RVU83bVnv2PfYc&oauth_verifier=sHcYKkGHMvBgR9FO5mxneccFZnXfRIe3mBBTjTSbzs
    def create
      # Set a constant for the environment's omniauth data
      omniauth = env["omniauth.auth"] # auth_hash
      # If the user is already logged in...
      if current_user
        # Add third party authentication method to the user's account
        current_user.user_tokens.find_or_create_by(:provider => omniauth['provider'], :uid => omniauth['uid'])
        # Apply data from the third party authentication provider into the user's account
        user.apply_omniauth(omniauth)
        flash[:notice] = "Successfully enabled #{omniauth['provider']} authentication."
        redirect_to edit_user_registration_path
      # If the user isn't logged in...
      else
        # Check to see if the omniauth data belongs to a user account
        user_token = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
        # If a user has used this third party authentication method before...
        if user_token
          # User successfully signed in via third party authentication
          user_token.user.apply_omniauth(omniauth)
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, user_token.user)
        # User has never signed in with this third party authentication
        else
          # Extract email address regardless of position in the omniauth data hash
          unless omniauth.recursive_find_by_key("email").blank?
            # User already exists in the system but hasn't used this third party authentication before
            user = User.find_or_initialize_by(:email => omniauth.recursive_find_by_key("email"))
          else
            # User is completely new
            user = User.omniauth_initialization
          end
          # Apply data from the third party authentication provider into the user's account
          user.apply_omniauth(omniauth)
          # Save user if valid
          if user.save
            # Automatically confirm user if user confirmed their email with the
            # third party authentication provider
            user.confirm! if User.confirmable? && !user.email.blank?
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
            sign_in_and_redirect(:user, user)
          # Prompt for additional information is user is invalid
          else
            session[:omniauth] = omniauth.except('extra')
            user.created_by_omniauth = false
            redirect_to new_user_registration_url
          end
        end
      end

    end

    protected

  # redirect_to request.env['omniauth.origin'] || '/default'

  end
end

