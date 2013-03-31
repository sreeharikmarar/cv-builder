# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class LinkedinDetails < ActiveRecord::Base

  ## Set the table name
  set_table_name "linkedin_details"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id, :first_name , :last_name , :headline , :city_id , :location_id , :industry_id , :company_id


  def self.parse_linkedin(user, profile_1)

    ## Storing Personal Detail
    
    @linkedin_detail = user.linkedin_details || LinkedinDetails.new
    
    @linkedin_detail.user_id = user.id
    @linkedin_detail.first_name = profile_1.first_name unless profile_1.first_name.blank?
    @linkedin_detail.last_name = profile_1.last_name unless profile_1.last_name.blank?
    @linkedin_detail.headline = profile_1.headline unless profile_1.headline.blank?
    @linkedin_detail.public_profile_url = profile_1.public_profile_url unless profile_1.public_profile_url.blank?

    unless profile_1.location.blank?
      ln_country = ""
      ln_city = ""
      if profile_1.location 
        begin
          ln_city = profile_1.location.name.split(",")[0].split("Area")[0].strip
          ln_country = profile_1.location.name.split(',').last.strip()

          if ln_city
            @city = Keyword::City.find_by_name(ln_city) || Keyword::City.create(:name=>ln_city, :user_id => user.id)
          end
          if ln_country
            @country = Keyword::Country.find_by_name(ln_country) || Keyword::Country.create(:name=>ln_country, :user_id => user.id)
          end
          
        rescue
          ln_city = ""
          ln_country = ""
        end
      end
    end
#    @linkedin_detail.city_id = @city.id
#    @linkedin_detail.country_id = @country.id
    @linkedin_detail.save(:validate => false)
      
    #    puts "*"*100

  end
  def self.parse_linkedin_2(user, profile_2)
    user.positions.destroy_all if user.positions
    
    if profile_2.positions && profile_2.positions.all && profile_2.positions.all.any?
      profile_2.positions.all.each do |pos|
        @position_details = Position.new
        @position_details.user_id = user.id
        
        @position_details.title = pos.title if pos.title
        @position_details.summary = pos.summary if pos.summary
        @position_details.is_current = pos.is_current
        @position_details.company_name = pos.company.name
        @position_details.industry_name = pos.company.industry

        
        #        @company = Keyword::Company.find_by_name(pos.company.name) || Keyword::Company.create(:name => pos.company.name, :user_id =>user.id )
        #        @industry = Keyword::Industry.find_by_name(pos.company.industry) || Keyword::Industry.create(:name => pos.company.industry , :user_id => user.id)
        #        role = Keyword::Role.find_by_name(pos.title) || Keyword::Role.new(:name => pos.title)
        #        @position_details.company_id = @company.id
        #        @position_details.industry_id = @industry.id

        if pos.is_current
          
          begin
            
            if pos.start_date && (pos.start_date.month && pos.start_date.year)
              start_date = "#{pos.start_date.month},#{pos.start_date.year}"
              end_date = "present"
            end
          rescue
            
            start_date = nil
            end_date = nil
          end
          @position_details.start_date = start_date
          @position_details.end_date = end_date
          #        elsif pos.is_current.to_s == "false"
        else
          
          begin
           
            if pos.start_date && pos.end_date
              if (pos.start_date.month && pos.end_date.month)  && (pos.start_date.year && pos.end_date.year)
                start_date = "#{pos.start_date.month},#{pos.start_date.year}"
                end_date = "#{pos.end_date.month},#{pos.end_date.year}"
              end
            end
          rescue
           
            start_date = nil
            end_date = nil
          end
          @position_details.start_date = start_date
          @position_details.end_date = end_date
         
        end
        @position_details.save
      end
    end
 
  
  end
  #  def self.parse_linkedin_2(user, profile_2)
  #
  #    ## profile_2 = c.profile(:fields=>["distance","summary","associations","honors","interests","industry","headline"])
  #
  #    ## Summary
  #    unless profile_2.summary.blank?
  #      summary = Cv::Summary.new
  #      summary.description = profile_2.summary
  #      summary.scrappable = user.cv
  #      summary.save(:validate => false)
  #    end
  #
  #    ## Achievements
  #    unless profile_2.honors.blank?
  #      achievements = Cv::Achievement.new
  #      achievements.title = profile_2.honors[0..20]
  #      achievements.description = profile_2.honors
  #      achievements.scrappable = user.cv
  #      achievements.save(:validate => false)
  #    end
  #
  #    ## Hobbies
  #    unless profile_2.interests.blank?
  #      hobbies = Cv::Hobbies.new
  #      hobbies.description = profile_2.interests
  #      hobbies.scrappable = user.cv
  #      hobbies.save(:validate => false)
  #    end
  #
  #    ## CV Title
  #    if profile_2.headline
  #      user.cv.title = profile_2.headline
  #      user.cv.save(:validate => false)
  #    end
  #
  #    # @todo
  #    #profile_2.industry
  #
  #  end
  #
  #  def self.parse_linkedin_3(user, profile_3)
  #
  #    ## profile_3 = c.profile(:fields=>["positions","three_current_positions","three_past_positions","publications","patents"])
  #
  #    ## Employment History
  #    if profile_3.positions && profile_3.positions.all && profile_3.positions.all.any?
  #      profile_3.positions.all.each do |pos|
  #        employment_history = Cv::EmploymentHistory.new
  #        company = Keyword::Company.find_by_name(pos.company.name) || Keyword::Company.new(:name => pos.company.name)
  #        employment_history.company = company
  #        industry = Keyword::Industry.find_by_name(pos.company.industry) || Keyword::Industry.new(:name => pos.company.industry)
  #        employment_history.industry = industry
  #        role = Keyword::Role.find_by_name(pos.title) || Keyword::Role.new(:name => pos.title)
  #        employment_history.role = role
  #        employment_history.present = pos.is_current
  #        employment_history.cv = user.cv
  #        employment_history.save(:validate => false)
  #      end
  #    end
  #
  #    ## Publications
  #    if profile_3.publications && profile_3.publications.all && profile_3.publications.all.any?
  #      profile_3.publications.all.each do |pub|
  #        publication = Cv::Publication.new
  #        publication.title = pub.title
  #        publication.date = Date.new(pub.date.year, pub.date.month, pub.date.day)
  #        publication.cv = user.cv
  #        publication.save(:validate => false)
  #      end
  #    end
  #
  #    ## Patents
  #    if profile_3.patents && profile_3.patents.all && profile_3.patents.all.any?
  #      profile_3.patents.all.each do |pat|
  #        patent = Cv::CustomSection.new
  #        patent.title = "Patents"
  #        patent.description = pat.title + " Date : #{pat.date.day}/#{pat.date.month}/#{pat.date.year}"
  #        patent.cv = user.cv
  #        patent.scrappable = user.cv
  #        patent.save(:validate => false)
  #      end
  #    end
  #
  #  end
  #
  #  def self.parse_linkedin_4(user, profile_4)
  #
  #    ## profile_4 = c.profile(:fields=>["languages","skills","certifications","educations"])
  #
  #    ## Languages
  #    if profile_4.languages && profile_4.languages.all && profile_4.languages.all.any?
  #      profile_4.languages.all.each do |lang|
  #        language = Cv::Language.new
  #        kwd_lang = Keyword::Language.find_by_name(lang.name) || Keyword::Language.new(:name => lang.name)
  #        language.language = kwd_lang
  #        lang.cv = user.cv
  #        lang.save(:validate => false)
  #      end
  #    end
  #
  #    ## Skills
  #    if profile_4.skills && profile_4.skills.all && profile_4.skills.all.any?
  #      profile_4.skills.all.each do |skl|
  #        skill = Cv::Skill.new
  #        skill.name = skl.skill.name
  #        skill.cv = user.cv
  #        skill.save(:validate => false)
  #      end
  #    end
  #
  #    ## Certifications
  #    if profile_4.certifications && profile_4.certifications.all && profile_4.certifications.all.any?
  #      profile_4.certifications.all.each do |cert|
  #        certification = Cv::Certification.new
  #        cert_kwd = Keyword::Certification.find_by_name(cert.name) || Keyword::Certification.new(:name => cert.name)
  #        certification.certification = cert_kwd
  #        certification.cv = user.cv
  #        certification.save(:validate => false)
  #      end
  #    end
  #
  #    ## Education Details
  #    if profile_4.educations && profile_4.educations.all && profile_4.educations.all.any?
  #      profile_4.educations.all.each do |edu|
  #        education = Cv::Education.new
  #        qualification = Keyword::Qualification.find_by_name(edu.degree) || Keyword::Qualification.new(:name => edu.degree)
  #        specialization = Keyword::Specialization.find_by_name(edu.field_of_study) || Keyword::Specialization.new(:name => edu.field_of_study)
  #        institution = Keyword::Institution.find_by_name(edu.school_name) || Keyword::Institution.new(:name => edu.school_name)
  #        edu_status = Keyword::EducationStatus.find_by_name("Graduated") || Keyword::EducationStatus.new(:name => "Graduated")
  #        education.education_status = edu_status
  #        education.qualification = qualification
  #        education.specialization = specialization
  #        education.institution = institution
  #        education.from = Date.new(edu.start_date.year, 1,1) if edu.start_date
  #        education.to = Date.new(edu.end_date.year, 1,1) if edu.end_date
  #        education.cv_id = user.cv.id
  #        education.save(:validate => false)
  #      end
  #    end
  #
  #  end
  #
end
