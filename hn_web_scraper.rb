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

# Pull data from the ".subtext" tag
doc.css('.subtext').each do |subtext|
    if subtext.at_css('span').class == Nokogiri::XML::Element
        puts subtext.at_css('span').text # Story points
    end
    if subtext.at_css('span+ a').class == Nokogiri::XML::Element
        puts subtext.at_css('span+ a').text # Story submitter
    end
    if subtext.at_css('a+ a').class == Nokogiri::XML::Element
        puts subtext.at_css('a+ a').text # Story comment count
    end
end
