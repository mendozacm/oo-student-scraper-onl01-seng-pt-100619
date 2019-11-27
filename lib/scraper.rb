require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   
    index_page = Nokogiri::HTML(open(index_url))
    students = []
  
    index_page.css("div.roster-cards-container").each do |card|
   
    card.css(".student-card a").each do |student|
     
    name = student.css(".student-name").text
    
    location = student.css(".student-location").text
    
    profile_url = student.attributes["href"].value
      
    student_hash = {
      :name => name,
      :location => location,
      :profile_url => profile_url
    }
    students << student_hash
    end
  end
    students
    end

  def self.scrape_profile_page(profile_url)
    
  profile_page = Nokogiri::HTML(open(profile_url))
  
  student_hash = {}
  
  profile_page.css(".vitals-text-container a").each do |profile|
  
  link = profile.attributes["href"].value
  
  if link.include?("twitter")
    student_hash[:twitter] = link
  elsif link.include?("linkedin")
    student_hash[:linkedin] = link 
  elsif link.include?("github")
    student_hash[:github] = link 
  else 
    student_hash[:blog] = link
  end
  
  profile_page = Nokogiri::HTML(open(profile_url))
  profile_page.css(".vitals-text-container div").each do |bio|
    bio = profile.attributes["class"].value
    
    
  end
  binding.pry
end
student_hash
  end

end

