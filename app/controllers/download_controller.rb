class DownloadController < ApplicationController

    layout "after-login"

  def preview
    collect_data_for_displaying_and_downloading_cv

    respond_to do |format|
      format.html {}
      format.js { render :preview }
    end

  end
  
  
  def download_cv

    @format = "pdf"
    @show_links = false

    collect_data_for_displaying_and_downloading_cv

    pdf_file_name = "SAMPLE_CV"

#    respond_to do |format|
#      format.html {
#        render :pdf => pdf_file_name,
#        :template => "/download/download_cv.html.erb",
#        :margin => {:top                => 0,
#                    :bottom             => 0,
#                    :left               => 0,
#                    :right              => 0},
#        :orientation      => 'Portrait', # default , Landscape,
#        :no_background    => true
#      }
#
##      respond_to do |format|
##      format.pdf {
##        render :pdf => "sample_CV",
##        :template => '/download/download_cv.html.erb'
##      }
#    end
    respond_to do |format|
      format.html {
        render :pdf => pdf_file_name,
        :footer => { :left => "Left", :text => "cv builder"},
        :template => '/download/download_cv.html.erb',
        :margin => {:top                => 0,
          :bottom             => 0,
          :left               => 0,
          :right              => 0},
        :orientation      => 'Portrait', # default , Landscape,
        :no_background    => true
      }
    end
  end

  private
  def collect_data_for_displaying_and_downloading_cv
    @user = current_user
    @linkedin_details = current_user.linkedin_details
    @experience_details = current_user.positions if current_user.positions.any?
    @github_details = current_user.github_details if current_user.github_details.any?
    @education_details = current_user.education_details if current_user.education_details.any?
    @technical_details = current_user.technical_details
  end

end
