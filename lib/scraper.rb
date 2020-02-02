require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    Nokogiri::HTML(html)
  end
  
  def get_courses
    doc = get_page
    courses = doc.css(".post")
    binding.pry
  end
  
  def make_courses
    courses = get_courses
    courses.each do |course|
      new_course = Course.new
      course.children.each do |element|
        if element.name == 'h2'
          new_course.title = element.text
        elsif element.name == "em"
          new_course.schedule = element.text
        elsif element.name == "p"
          new_course.description = element.text
        end
      end
    end
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end



