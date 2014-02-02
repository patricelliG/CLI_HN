require 'open-uri'
require 'nokogiri'

# The story class 
class Story
    attr_accessor :name, :source, :points, :submitter, :comments
end

# Initialize the array of stories
# One story object for each story is created as a placeholder for now
num_stories = 30
stories = Array.new 
count = 0
until count == num_stories do
    stories << Story.new
    count += 1
end

# Pull the HTML and create a new Nokogiri document
doc = Nokogiri::HTML(open("https://news.ycombinator.com/"))

# Pull data fields from the ".title" CSS tag 
name_count = 0 # The number of names that have been put into the stories array
source_count = 0 # The number of sources that have been put into the stories array
doc.css('.title~ .title').each do |title|
    if title.at_css('a').class == Nokogiri::XML::Element
        # This is the story title, store it in the array and increment the count
        stories[name_count].name = title.at_css('a').text # Story name
        name_count += 1
    end
    if title.at_css('.comhead').class == Nokogiri::XML::Element
        # This is the story source, store it in the array and increment the count
        stories[source_count].source = title.at_css('.comhead').text # Story source
        source_count += 1
    end
end

# Pull data fields from the ".subtext" CSS tag
point_count = 0 # The number of points that have been put into the stories array
submitter_count = 0 # The number of submitters that have been put into the stories array
comment_count = 0 # The number of comments that have been put into the stories array
doc.css('.subtext').each do |subtext|
    if subtext.at_css('span').class == Nokogiri::XML::Element
        # This is the number of points the story receive, store it in the array and increment the count
        stories[point_count].points = subtext.at_css('span').text # Story points
        point_count += 1
    end
    if subtext.at_css('span+ a').class == Nokogiri::XML::Element
        # This is the submitter's name, store it and increment the count
        stories[submitter_count].submitter = subtext.at_css('span+ a').text # The user that submitted the story 
        submitter_count += 1
    end
    if subtext.at_css('a+ a').class == Nokogiri::XML::Element
        # This is the number of comments for the story, store it and increment the count
        stories[comment_count].comments =  subtext.at_css('a+ a').text # Story comment count
        comment_count += 1
    end
end

# Check if the user requested sorting
if ARGV[0] == '-s'
    # User requests a sort
    if ARGV[1] == 'name'
        # Sort by name
        stories.sort_by! &:name
    elsif ARGV[1] == 'source'
        # Sort by source
        stories.sort_by! &:source
    elsif ARGV[1] == 'points'
        # Sort by points
        stories.sort_by! &:points
    elsif ARGV[1] == 'submitter'
        # Sort by submitter
        stories.sort_by! &:submitter
    elsif ARGV[1] == 'comments'
        # Sort by number of comments
        stories.sort_by! &:comments
   else
        # User entered an invalid field
   end
end    

# Print the stories to the terminal
stories.each do |story| 
   puts
   puts "   #{story.name}   #{story.source}"
   puts "       < #{story.points} | #{story.submitter} | #{story.comments} > "
end

# Give credit where credit is due...
puts "\nAll content provided by \'https://news.ycombinator.com\'."
