class HomeController < ApplicationController
  before_filter :redirect_to_home_if_signed_in
  def index
    
  end
end
