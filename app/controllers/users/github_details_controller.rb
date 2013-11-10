class Users::GithubDetailsController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  
  def edit
    @git_details = GithubDetails.find_by_id_and_user_id(params[:id],current_user.id)

    respond_to do |format|
      format.js {}
    end
  end

  def update
    @git_details =  GithubDetails.find_by_id_and_user_id(params[:id],current_user.id)

    @git_details.user_id = current_user.id
    
      @git_details.project_name = params[:git_details][:project_name]

      @git_details.technologies = params[:git_details][:technologies]
    
      @git_details.project_description = params[:git_details][:project_description]
      
      @git_details.contribution = params[:git_details][:contribution]
    
    if @git_details.valid?
      @git_details.save
      @github_details = current_user.github_details
      respond_to do |format|
        format.js { render :update}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
    end
    
  end
  
  
  
  def delete
    @git_details = GithubDetails.find_by_id_and_user_id(params[:id],current_user.id)
    @git_details.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
end
