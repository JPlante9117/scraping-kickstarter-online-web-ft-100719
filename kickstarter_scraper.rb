require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  project_html = kickstarter.css("li.project.grid_4")
  
  projects = {}
  
  project_html.each do |project|
    title = project_html.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: project_html.css("div.project-thumbnail a img").attribute("src").value,
      description: project_html.css("p.bbcard_blurb").text,
      location: project_html.css("ul.project-meta li a").text,
      percent_funded: project_html.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i,
    }
  end
  #binding.pry
end

create_project_hash

#projects = kickstarter.css("li.project.grid_4")
#title = projects.css("h2.bbcard_name strong a").text
#img = projects.css("div.project-thumbnail a img").attribute("src").value
#description = projects.css("p.bbcard_blurb").text
#location = projects.css("ul.project-meta li a").text
#funded = projects.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i