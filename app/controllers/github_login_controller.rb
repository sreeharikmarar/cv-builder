class GithubLoginController < ApplicationController

  def authorize
    config = YAML::load(File.open("#{Rails.root.to_s}/config/github.yml"))
    @github = Github.new :client_id => config[Rails.env]["app_id"], :client_secret => config[Rails.env]["secret_key"]
    address = @github.authorize_url :redirect_uri => "http://#{request.host_with_port}/github/callback", :scope => 'repo'
    puts "1"*100
    puts address.inspect
    redirect_to address
  end

  def callback
    authorization_code = params[:code].to_s

    config = YAML::load(File.open("#{Rails.root.to_s}/config/github.yml"))
    @github = Github.new :client_id => config[Rails.env]["app_id"], :client_secret => config[Rails.env]["secret_key"]
    token = @github.get_token(authorization_code)
    
    access_token = token.token
    

#    req = Net::HTTP.get(URI.parse("https://api.github.com/user/repos?access_token=#{access_token}"))


    # To get the whole repos list in browser https://api.github.com/user/repos?access_token=#{access_token}
    
     response =  RestClient.get("https://api.github.com/user/repos?access_token=#{access_token}")
     datas = JSON.parse(response)
    
     GithubDetails.parse_github(current_user, datas)
   
    redirect_to dashboard_path
  end
end
