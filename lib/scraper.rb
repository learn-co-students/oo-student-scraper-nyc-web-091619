require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.student-card a").each do |student|
      name = student.css(".student-name").text
      loca = student.css(".student-location").text
      link = student.attribute("href").value
      students << {name: name, location: loca, profile_url: link}
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    # binding.pry
    profile_page.css(".social-icon-container a").each do |icon|
      icon_href = icon.attribute("href").value
      # case icon_href
      # when include?("twitter")
      #   profile_hash[:twitter] = icon.attribute("href").value
      # when include?("linkedin")
      #   profile_hash[:linkedin] = icon.attribute("href").value
      # when include?("github")
      #   profile_hash[:github] = icon.attribute("href").value
      # else
      #   profile_hash[:blog] = icon.attribute("href").value
      # end
      if icon_href.include?("twitter")
        profile_hash[:twitter] = icon_href
      elsif icon_href.include?("linkedin")
        profile_hash[:linkedin] = icon_href
      elsif icon_href.include?("github")
        profile_hash[:github] = icon_href
      else
        profile_hash[:blog] = icon_href
      end
    end
    profile_hash[:profile_quote] = profile_page.css(".profile-quote").text
    profile_hash[:bio] = profile_page.css(".description-holder p").text
    # binding.pry
    profile_hash
  end

end

