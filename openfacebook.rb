# coding: utf-8

require 'rubygems'
require 'mechanize' 

# extract the URL as string from the Nokogiri object
def extract_url(element)
  element.attributes['href'].to_s
end

# take a URL string and return a Nokogiri page object
def open_page(url)
  page= WWW::Mechanize.new.get(url)
end

# extracts friends Nokogiri objects from the Nokogiri page object
def extract_friends_for(page)
  friends_urls= []
  page.search(%|a[@rel="friend"]|).each {|e| friends_urls << extract_url(e)}
  friends_urls.uniq #xpath issue
end

# take a URL string and return an array of friends URLs
def crawl(url)
  page= open_page(url)
  extract_friends_for(page)
end

