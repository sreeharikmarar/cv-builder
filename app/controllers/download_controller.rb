class DownloadController < ApplicationController

    layout "after-login"

  def preview
    collect_data_for_displaying_cv

    if @user
      respond_to do |format|
        format.html {}
      end
    else
      respond_to do |format|
        format.html { render :request_denied}
      end
    end
  end
  
  
  def download_cv

    collect_data_for_displaying_and_downloading_cv

    pdf_file_name = "#{current_user.name}"


    respond_to do |format|
      format.html {
        render :pdf => pdf_file_name,
        :footer => { :text => "cv builder"},
        :template => '/download/download_cv.html.erb',
        :margin => {:top      => 5,
          :bottom             => 5,
          :left               => 5,
          :right              => 5},
        :orientation      => 'Portrait', # default , Landscape,
        :no_background    => false
      }
    end
  end

  private

  def collect_data_for_displaying_and_downloading_cv
    @theme = params[:theme]
    @user = User.find_by_id(params[:id])
    @format = "pdf"
    @show_links = false
    
    @linkedin_details = @user.linkedin_details if @user && !@user.linkedin_details.blank?
    @experience_details = @user.positions if @user && @user.positions.any?
    @github_details = @user.github_details if @user && @user.github_details.any?
    @education_details = @user.education_details if @user && @user.education_details.any?
    @technical_details = @user.technical_details
    @projects = @user.projects
  end
  def collect_data_for_displaying_cv
    @user = User.find_by_id(params[:id])
    @linkedin_details = @user.linkedin_details if @user && !@user.linkedin_details.blank?
    @experience_details = @user.positions if @user && @user.positions.any?
    @github_details = @user.github_details if @user && @user.github_details.any?
    @education_details = @user.education_details if @user && @user.education_details.any?
    @technical_details = @user.technical_details
    @projects = @user.projects
  end

end
