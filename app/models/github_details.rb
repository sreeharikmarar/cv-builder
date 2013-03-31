# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class GithubDetails < ActiveRecord::Base

  ## Set the table name
  set_table_name "github_details"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id, :project_name , :project_description ,:public_url , :technologies , :create_at , :updated_at , :contribution


  def self.parse_github(user, datas)
    user.github_details.destroy_all if user.github_details.any?
    puts "*"*100
      datas.each do |item|
       puts "-"*100
      @github_detail = GithubDetails.new
      @github_detail.user_id = user.id
      puts "@github_detail.user_id : #{@github_detail.user_id}"
      @github_detail.project_name = item["name"]
      puts "@github_detail.project_name  : #{@github_detail.project_name}"
      @github_detail.project_description = item["description"]
      puts "@github_detail.project_description  : #{@github_detail.project_description}"
      @github_detail.public_url = item["html_url"]
      puts "@github_detail.public_url  : #{@github_detail.public_url}"
      @github_detail.technologies = item["language"]
      puts " @github_detail.technologies  : #{@github_detail.technologies}"
      @github_detail.created_at = item["created_at"]
      puts " @github_detail.created_at : #{ @github_detail.created_at}"
      @github_detail.updated_at = item["updated_at"]
      puts " @github_detail.updated_at : #{@github_detail.updated_at}"
      @github_detail.contribution = ''
      @github_detail.save
       puts "="*100
    end
  end
end
