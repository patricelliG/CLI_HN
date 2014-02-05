# Written by Gary Patricelli
# On or about 02/03/2014
# For CSC 435
# All content provided by https://news.ycombinator.com

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
story_count = 0 # The story number we are currently processing 
doc.css('.title~ .title').each do |title|
    if title.at_css('a').class == Nokogiri::XML::Element
        # This is the story title, store it in the array and increment the count
        stories[story_count].name = title.at_css('a').text # Story name
    end
    if title.at_css('.comhead').class == Nokogiri::XML::Element
        # This is the story source, store it in the array and increment the count
        stories[story_count].source = title.at_css('.comhead').text # Story source
    else
        # This is a blank field, it may be a post from ycombinator
        # Add a filler so that sorting is not broken
        stories[story_count].source = '(ycombinator)'
    end
    story_count += 1
end

# Pull data fields from the ".subtext" CSS tag
story_count = 0 # The story number we are currently processing 
doc.css('.subtext').each do |subtext|
    if subtext.at_css('span').class == Nokogiri::XML::Element
        # This is the number of points the story receive, store it in the array and increment the count
        stories[story_count].points = subtext.at_css('span').text[0..-8].to_i # Story points
    else
        # This is a blank field, it may be a post from ycombinator
        # Add a filler so that sorting is not broken
        stories[story_count].points = 0
    end
    if subtext.at_css('span+ a').class == Nokogiri::XML::Element
        # This is the submitter's name, store it and increment the count
        stories[story_count].submitter = subtext.at_css('span+ a').text # The user that submitted the story 
    else
        # This is a blank field, it may be a post from ycombinator
        # Add a filler so that sorting is not broken
        stories[story_count].submitter = 'ycombinator'
    end
    if subtext.at_css('a+ a').class == Nokogiri::XML::Element
        # This is the number of comments for the story, store it and increment the count
        stories[story_count].comments =  subtext.at_css('a+ a').text[0..-8].to_i # Story comment count
    else
        # This is a blank field, it may be a post from ycombinator
        # Add a filler so that sorting is not broken
        stories[story_count].comments = 0
    end
    story_count += 1
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
   puts "       < #{story.points} points | #{story.submitter} | #{story.comments} comments > "
end

# Give credit where credit is due...
puts "\nAll content provided by \'https://news.ycombinator.com\'."
