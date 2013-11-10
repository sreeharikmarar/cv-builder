class ProfileController < ApplicationController
  
  layout "public"

    
  def show
    @user = User.find_by_id(params[:id])
    if @user
      if @user.share_cv && @user.share_cv.publish?
        @linkedin_details = @user.linkedin_details
        @experience_details = @user.positions if @user.positions.any?
        @github_details = @user.github_details if @user.github_details.any?
        @education_details = @user.education_details if @user.education_details.any?
        @technical_details = @user.technical_details
        @projects = @user.projects
        @theme = @user.share_cv.theme
        
        respond_to do |format|
          format.html {}
          format.js { }
        end
      else
        respond_to do |format|
          format.html { render :permission_denied}
          format.js { }
        end
      end
    else
      respond_to do |format|
        format.html { render :request_denied}
        format.js { }
      end
    end
  end
end


