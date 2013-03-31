class GithubLoginController < ApplicationController

  def authorize
    @github = Github.new :client_id => 'c3c55176248542521759', :client_secret => 'e5673dbb73c7e010781e8c1457d20a796ad9c19d'
    address = @github.authorize_url :redirect_uri => 'http://localhost:3000/github/callback', :scope => 'repo'
    puts "1"*100
    puts address.inspect
    redirect_to address
  end

  def callback
    authorization_code = params[:code].to_s
#    puts "%"*100
#    puts @github.methods
#    puts "@"*100
    @github = Github.new :client_id => 'c3c55176248542521759', :client_secret => 'e5673dbb73c7e010781e8c1457d20a796ad9c19d'
    token = @github.get_token(authorization_code)
    puts "#"*100
    puts  token.inspect
    puts "$"*100
    access_token = token.token
    puts "$"*100
    puts "access tocken :#{access_token} "
    puts "$"*100
#    github = Github.new do |config|
#      config.endpoint    = 'https://api.github.com/user/repos'
#      config.oauth_token = access_token
#      config.adapter     = :net_http
#    end
#    puts "%"*100
#    puts  github.to_json
#    puts "^"*100
#    require 'net/http'
#    req = Net::HTTP.get(URI.parse("https://api.github.com/user/repos?access_token=#{access_token}"))
#    puts"="*100
#     require 'rest-client'

    # To get the whole repos list in browser https://api.github.com/user/repos?access_token=7e349d6d8173b0fca65f64e8ebffc683024b9415 
     response =  RestClient.get("https://api.github.com/user/repos?access_token=#{access_token}")
     datas = JSON.parse(response)
     puts "^"*100
     GithubDetails.parse_github(current_user, datas)
    
#    token = @github.get_token(authorization_code)
#     items = JSON.parse(access_token.get('/api/v2/json/user/show'))
#    github = Github.new :access_token => token.to_s , :scope =>'repo'
#    items = github.authorize_url :scope => 'repo'
#    puts "*"*100
#    puts items
#    puts github.users.inspect
#    puts github.users.to_json
#    puts github.repos.list

    github = Github.new do |config|
  config.endpoint    = 'https://github.company.com/api/v3'
  config.oauth_token = access_token 
  config.adapter     = :net_http
end

    puts github.to_json
    redirect_to dashboard_path
  end
end