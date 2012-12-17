class GithubLoginController < ApplicationController

  def authorize
    @github = Github.new :client_id => 'c3c55176248542521759', :client_secret => 'e5673dbb73c7e010781e8c1457d20a796ad9c19d'
    address = @github.authorize_url :redirect_uri => 'http://localhost:3000/github/callback', :scope => 'repo'
    puts address.inspect
    redirect_to address
  end

  def callback
    authorization_code = params[:code]
#    puts "%"*100
#    puts @github.methods
#    puts "@"*100
    @github = Github.new :client_id => 'c3c55176248542521759', :client_secret => 'e5673dbb73c7e010781e8c1457d20a796ad9c19d'
    token = @github.get_token(authorization_code)
#    puts "#"*100
#    puts  token.inspect
#    puts "$"*100
    access_token = token.token
#    puts "%"*100
#    puts  access_token
#    puts "^"*100
#    require 'net/http'
#    req = Net::HTTP.get(URI.parse("https://api.github.com/user?access_token='#{access_token }"))
#    puts req
#    token = @github.get_token(authorization_code)
#     items = JSON.parse(access_token.get('/api/v2/json/user/show'))
#    github = Github.new :access_token => token.to_s , :scope =>'repo'
#    items = github.authorize_url :scope => 'repo'
#    puts "*"*100
#    puts items
#    puts github.users.inspect
#    puts github.users.to_json
#    puts github.repos.list

    redirect_to dashboard_path
  end
end