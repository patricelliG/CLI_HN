require 'open-uri'
require 'nokogiri'

# Make the story class
class Story
    # Set description given as the title on HN
    def name=(name)
        @name = name
    end
    # Set the story's source i.e. NY times
    def source=(source)
        @source = source
    end
    # Set the number of upvotes received by the story
    def points=(points)
        @points = points
    end
    # Set the name of the user who submitted the story
    def submitter=(submitter)
        @submitter = submitter
    end
    # Set the number of comments received by the story
    def comments=(comments)
        @comments = comments
    end

    # Get description given as the title on HN
    def name
        @name
    end
    # Get the story's source i.e. NY times
    def source
        @source
    end
    # Get the number of upvotes received by the story
    def points 
        @points
    end
    # Get the name of the user who submitted the story
    def submitter
        @submitter
    end
    # Get the number of comments received by the story
    def comments
        @comments
    end
end

# Initialize the array of stories
num_stories = 30
stories = Array.new 
count = 0
until count == num_stories + 1  do
    stories << Story.new
    count += 1
end

# Pull the HTML and create a new nokogiri document
doc = Nokogiri::HTML(open("https://news.ycombinator.com/"))

# Pull data feilds from the ".title" tag and assign them to story objects
name_count = 0 
source_count = 0 
doc.css('.title').each do |title|
    if title.at_css('a').class == Nokogiri::XML::Element
        stories[name_count].name = title.at_css('a').text # Story name
        name_count += 1
    end
    if title.at_css('.comhead').class == Nokogiri::XML::Element
        stories[source_count].source = title.at_css('.comhead').text # Story source
        source_count += 1
    end
end

# Pull data fields from the ".subtext" tag
point_count = 0
submitter_count = 0
comment_count = 0
doc.css('.subtext').each do |subtext|
    if subtext.at_css('span').class == Nokogiri::XML::Element
        stories[point_count].points = subtext.at_css('span').text # Story points
        point_count += 1
    end
    if subtext.at_css('span+ a').class == Nokogiri::XML::Element
        stories[submitter_count].submitter = subtext.at_css('span+ a').text # The user that submitted the story 
        submitter_count += 1
    end
    if subtext.at_css('a+ a').class == Nokogiri::XML::Element
        stories[comment_count].comments =  subtext.at_css('a+ a').text # Story comment count
        comment_count += 1
    end
end

stories.each do |story| 
   puts
   puts "   #{story.name}   #{story.source}"
   puts "       < #{story.points} | #{story.submitter} | #{story.comments} > "
end
