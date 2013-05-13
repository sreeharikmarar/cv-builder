class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:notice] = "You have already registerd in Cv builder with the same email id #{request.env["omniauth.auth"]["info"]["email"]}.please select the same Provider and log in again "
      redirect_to root_path
    end
  end


  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      flash[:notice] = "You have already registerd in Cv builder with the same email id #{request.env["omniauth.auth"]["info"]["email"]}.please select the same Provider and log in again "
      redirect_to root_path
    end
	end

  def twitter
    auth = env["omniauth.auth"]
    Rails.logger.info("auth is **************** #{auth.to_yaml}")
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      flash[:notice] = "You have already registerd in Cv builder with the same email id #{request.env["omniauth.auth"]["info"]["email"]}.please select the same Provider and log in again "
      redirect_to root_path
    end
  end

end