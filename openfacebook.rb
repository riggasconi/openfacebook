# coding: utf-8

# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

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

# extract friends Nokogiri objects from the Nokogiri page object
def extract_friends_for(page)
  friends_urls= []
  page.search(%|a[@rel="friend"]|).each {|e| friends_urls << extract_url(e)}
  friends_urls.uniq #xpath issue
end

# take a URL (NOTE: need to check validity) or a facebook vanity name
# and return a valid facebook public page URL
def make_url_from(string)
  if string.match(/http:\/\//) # assuming it's a valid facebook public page URL
    return string
  else # assuming it's a vanity name
    return "http://www.facebook.com/#{string}"
  end
end

# take a URL string and return an array of friends URLs
def friends(url_or_vanity_name)
  url= make_url_from(url_or_vanity_name)
  page= open_page(url)
  extract_friends_for(page)
end