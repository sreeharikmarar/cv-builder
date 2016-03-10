require 'rubygems'
require 'linkedin'

class LinkedinUserController < ApplicationController

  #  before_filter :require_individual, :only=>[:callback]

  def init_client
    # API KEYS : https://www.linkedin.com/secure/developer
    config = YAML::load(File.open("#{Rails.root.to_s}/config/linkedin.yml"))
    key = config[Rails.env]["app_id"]
    secret = config[Rails.env]["secret_key"] 
    linkedin_configuration = { :site => 'https://api.linkedin.com',
        :authorize_path => '/uas/oauth/authenticate',
        :request_token_path =>'/uas/oauth/requestToken?scope=r_basicprofile+r_emailaddress',
        :access_token_path => '/uas/oauth/accessToken' }
    @linkedin_client = LinkedIn::Client.new(key, secret,linkedin_configuration )
  end

  def auth
    init_client
    request_token = @linkedin_client.request_token(:oauth_callback => "http://#{request.host_with_port}/linkedin/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    redirect_to @linkedin_client.request_token.authorize_url
  end

  def callback
    init_client
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret =  @linkedin_client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      @linkedin_client.authorize_from_access(session[:atoken], session[:asecret])
    end

    c = @linkedin_client
    
    profile_1 = c.profile(:fields=>["first_name","last_name","headline","public_profile_url","date-of-birth","main_address","phone-numbers","primary-twitter-account","twitter-accounts","location"])

    LinkedinDetails.parse_linkedin1(current_user, profile_1)

    profile_2 = c.profile(:fields=>["positions","three_current_positions","three_past_positions","publications","patents"])

    LinkedinDetails.parse_linkedin_2(current_user, profile_2)
    
    session[:atoken] = nil
    session[:asecret] = nil
    redirect_to dashboard_path(:imported_from_linkedin=>"success")
  end

end