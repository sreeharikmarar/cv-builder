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
        :request_token_path =>'/uas/oauth/requestToken?scope=r_basicprofile+r_fullprofile+r_emailaddress+r_network+r_contactinfo',
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

    puts "profile_2 = #{profile_2}"

    LinkedinDetails.parse_linkedin_2(current_user, profile_2)
    
    ##    ImportDetail::Linkedin.parse_linkedin_3(current_individual, profile_3)
    profile_3 = c.profile(:fields=>["languages","skills","certifications","educations"])
    puts "profile_3 = #{profile_3}"

    LinkedinDetails.parse_linkedin_3(current_user, profile_3)
    #    ImportDetail::Linkedin.parse_linkedin_4(current_individual, profile_4)

    ## Set preference to linked in
    #current_individual.set_resume_preference("linkedin")
    #current_individual.set_resume_preference("cv_builder")
    session[:atoken] = nil
    session[:asecret] = nil
    redirect_to dashboard_path(:imported_from_linkedin=>"success")
  end

  def test_console
    key = "zrjfxj4j6u8i"
    secret = "OFHzBKYQxSNW66wy"
    c = LinkedIn::Client.new(key, secret)
    request_token = c.request_token(:oauth_callback => "http://localhost:3000/linkedin/import")
    rtoken = request_token.token
    rsecret = request_token.secret
    c.request_token.authorize_url
    pin = "73207"
    atoken, asecret = c.authorize_from_request(rtoken, rsecret, pin)
    atoken = "b8526f9a-2cde-4850-a451-d08a66742287"
    asecret = "1def96c8-597c-4bb5-b866-2413c90ec6d2"
    c.authorize_from_access(atoken, asecret)
    p = c.profile
    #@linkedin_connections = @linkedin_client.connections
  end

end