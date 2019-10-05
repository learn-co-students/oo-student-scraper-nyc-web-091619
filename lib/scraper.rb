require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []

    index.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each  do |card|
        student_url         = card.attr('href')
        student_location    = card.css('.student-location').text
        student_name        = card.css('.student-name').text
        students << {
          name: student_name, 
          location: student_location, 
          profile_url: student_url
        }
      end
    end
    students
    # binding.pry
  end
end

def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    binding.pry
    
    student = {}
    
end

