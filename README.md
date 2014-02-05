hn_cli
======

### Description
A web scraper written in Ruby for my programming languages course. This scraper uses Nokogiri to pull the hacker news headlines from first page of https://news.ycombinator.com web page. The data is presented to the user via a command line interface. The user may sort the stories as they see fit. 

### Supports Sorting by the Following Fields
* name
* source
* submitter
* points
* comments 

### User Instructions
Simply call the ruby script to display the stories as in the example below:

**$ ruby hn_cli.rb**

If you want to sort the results by one of the fields listed above pass a 's' flag followed by the field name:

**$ ruby hn_cli.rb -s 'field name'**

So if you wanted to sort by number of comments you input the following:

**$ ruby hn_cli.rb -s comments**

And thats it!

### TO DO
* Launch the story from the command line?




