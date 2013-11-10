class Users::ProjectsController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  def new
    @project = Projects.new

    respond_to do |format|
      format.js { render :edit }
    end
  end

  def edit
    @project = Projects.find_by_id_and_user_id(params[:id],current_user.id)

    respond_to do |format|
      format.js {}
    end
  end

  def update
    @project =  Projects.find_by_id_and_user_id(params[:id],current_user.id)

    @project.user_id = current_user.id
    
#    if params[:projects][:project_name].blank?
#      @project.errors.add(:project_name , "can't be blank")
#    else
      @project.project_name = params[:projects][:project_name]
#    end

     @project.technologies = params[:projects][:technologies]

     @project.public_url = params[:projects][:public_url]

    @project.project_description = params[:projects][:project_description]
    
    @project.contribution = params[:projects][:contribution]
    
    if @project.valid?
      @project.save
      @projects = current_user.projects
      respond_to do |format|
        format.js { render :update}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
    end
    
  end
  
  def create
    @project =  Projects.new

    @project.user_id = current_user.id

#    if params[:projects][:project_name].blank?
#      @project.errors.add(:project_name , "can't be blank")
#    else
      @project.project_name = params[:projects][:project_name]
#    end

    
    @project.technologies = params[:projects][:technologies]

    
    @project.public_url = params[:projects][:public_url]

    @project.project_description = params[:projects][:project_description]
    

    @project.contribution = params[:projects][:contribution]

    if @project.valid?
      @project.save
      @projects = current_user.projects
      respond_to do |format|
        format.js { render :create}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
    end

  end
  
  def delete
    @projects = Projects.find_by_id_and_user_id(params[:id],current_user.id)
    @projects.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
end
