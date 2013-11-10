class HomeController < ApplicationController
  
  before_filter :redirect_to_home_if_signed_in , :only => :index

  def index
    
  end

  def about
    
  end
end
