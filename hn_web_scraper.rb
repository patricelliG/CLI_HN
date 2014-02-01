require 'open-uri'
require 'nokogiri'

# Pull the HTML and create a new nokogiri document
doc = Nokogiri::HTML(open("https://news.ycombinator.com/"))

# Pull data feilds from the ".title" tag
doc.css('.title').each do |title|
    if title.at_css('a').class == Nokogiri::XML::Element
        puts title.at_css('a').text # Story name
    end
    if title.at_css('.comhead').class == Nokogiri::XML::Element
        puts title.at_css('.comhead').text # Story source
    end
end

# Pull data fields from the ".subtext" tag
doc.css('.subtext').each do |subtext|
    if subtext.at_css('span').class == Nokogiri::XML::Element
        puts subtext.at_css('span').text # Story points
    end
    if subtext.at_css('span+ a').class == Nokogiri::XML::Element
        puts subtext.at_css('span+ a').text # The user that submitted the story 
    end
    if subtext.at_css('a+ a').class == Nokogiri::XML::Element
        puts subtext.at_css('a+ a').text # Story comment count
    end
end


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
    def commnents
        @comments
    end
end

