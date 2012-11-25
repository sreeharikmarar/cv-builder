class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    sign_in_url = dashboard_url
  end

   def require_user
     unless user_signed_in?
       flash[:notice] = "You must be logged in to access this page"
       respond_to do |format|
         format.html { redirect_to root_path }
       end
       return false
     end
      @user = current_user
   end

end
