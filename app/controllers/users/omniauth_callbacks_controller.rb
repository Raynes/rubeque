class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    sign_in_or_register(:twitter)
  end

  def github
    sign_in_or_register(:github)
  end

  def google
    @user = User.find_for_open_id(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private

    def sign_in_or_register(provider)
      if !User.omniauth_providers.index(provider).nil?
        omniauth = env["omniauth.auth"]

        if current_user
          current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
           flash[:notice] = "Authentication successful"
           redirect_to edit_user_registration_path
        else
          user_token = UserToken.where(provider: omniauth['provider'], uid: omniauth['uid']).first

          if user_token
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
            sign_in_and_redirect(:user, user_token.user)
          else
            user = User.new
            user.apply_omniauth(omniauth)

            if user.save
              flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider'] 
              sign_in_and_redirect(:user, user)
            else
              session[:omniauth] = omniauth.except('extra')
              flash[:error] = "Could not create new user account"
              redirect_to new_user_registration_url
            end
          end
        end
      end
    end

end
