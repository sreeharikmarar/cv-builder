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
    
    if params[:git_details][:project_name].blank?
      @git_details.errors.add(:project_name, "can't be blank")
    else
      @git_details.project_name = params[:git_details][:project_name]
    end

    if params[:git_details][:technologies].blank?
      @git_details.errors.add(:technologies, "can't be blank")
    else
      @git_details.technologies = params[:git_details][:technologies]
    end
    
    unless params[:git_details][:contribution].blank?
      @git_details.contribution = params[:git_details][:contribution]
    end
    
    if @git_details.errors.blank?
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
