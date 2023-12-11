require 'open-uri'
require 'nokogiri'

class Parser
  def initialize(url, headers)
    @url = url
    @headers = headers
  end

  def parse_website
    begin
      page = Nokogiri::HTML(URI.open(@url, @headers))
    rescue OpenURI::HTTPError => e
      puts "HTTP Error: #{e.message}"
      return { courses: [] }
    end

    courses = page.css('.image-and-text-card')
    courses_data = courses.map do |course|
      name = course.css('.h3').text.strip
      faculty = course.css('ul li:nth-child(1) strong').text.strip
      semester = course.css('ul li:nth-child(2) strong').text.strip
      image_url = course.css('.image-part img')[0]['src']
      width = course.css('.image-part img')[0]['width']
      height = course.css('.image-part img')[0]['height']

      {name: name,
        faculty: faculty,
        semester: semester,
        image_url: image_url,
        width: width,
        height: height
      }
    end

    { courses: courses_data }
  end
end
