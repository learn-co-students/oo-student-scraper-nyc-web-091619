require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)

    student_array= []

    #get the page
    page = Nokogiri::HTML(open(index_url))
    
    #get the students
    students = page.css(".roster-cards-container div.student-card")

    #make the students
    students.each do |student|
       this_student = {}
       this_student[:name]= student.css("a div.card-text-container h4.student-name").text
       this_student[:profile_url] = student.css("a").attribute("href").value
       this_student[:location] = student.css(".student-location").text
      
       student_array << this_student
      
    end

    student_array

  end 

  def self.scrape_profile_page(profile_url)

    #get the page
    profile = Nokogiri::HTML(open(profile_url))

    social = profile.css("div.social-icon-container a")

    #build the hash
    profile_info = {}
    profile_info[:profile_quote] = profile.css("div.vitals-container div.profile-quote").text
    profile_info[:bio] = profile.css("div.bio-content .description-holder p").text

    social.each do |social_bit|
      case social_bit.css("img").attribute("src").text
        when "../assets/img/twitter-icon.png"
          profile_info[:twitter] = social_bit.attribute("href").value 
        when "../assets/img/linkedin-icon.png"
          profile_info[:linkedin] = social_bit.attribute("href").value 
        when "../assets/img/github-icon.png"
          profile_info[:github] = social_bit.attribute("href").value
        when "../assets/img/rss-icon.png"
          profile_info[:blog] = social_bit.attribute("href").value 
      end
    end
    
    profile_info
     
  end

end


