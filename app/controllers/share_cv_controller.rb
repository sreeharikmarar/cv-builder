class ShareCvController < ApplicationController
  
  before_filter :require_user
  layout "after-login"

  def share
    @share_cv = current_user.share_cv ? current_user.share_cv : ShareCv.new
    
    @share_cv.theme = "simple" if @share_cv && @share_cv.theme.nil?
    if Rails.env.production?
      bitly = Bitly.new("sreeharikmarar", "R_4f00b6fbbd62eaa6c81a48b9b0d7dab4")
      b = bitly.shorten("http://#{request.host_with_port}/profile/"+current_user.id.to_s)
      @url =  b.short_url
    else
      @url =  "http://#{request.host_with_port}/profile/"+current_user.id.to_s
    end
      
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end
  
  def publish_cv

    share_cv  = current_user.share_cv ? current_user.share_cv : ShareCv.new
    
    share_cv.url =  params[:share_cv][:url]
    share_cv.user_id =  current_user.id
    share_cv.theme = params[:share_cv][:theme]
    share_cv.publish = params[:share_cv][:publish]
    share_cv.save
    respond_to do |format|
      format.html {}
      format.js { }
    end
    
  end
  
end


