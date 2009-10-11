# coding: utf-8

require 'rubygems'
require 'mechanize' 

def extract_url(element)
  element.attributes['href'].to_s # nokogiri object => string
end

def extract_facebook_id(string)
  string.match(/(\w+|\w+\.\w+|\w+\.\w+\.\w+|\w+\.\w+\.\w+\.\w+)\z/).to_s
end

def open_page(url)
  page= WWW::Mechanize.new.get(url)
  page
end

def extract_friends_urls_for(url)
  friends_urls= []
  open_page(url).search(%|a[@rel="friend"]|).each {|e| friends_urls << extract_url(e)}
  friends_urls.uniq #xpath issue
end

def crawl(url)
  extract_friends_urls_for(url)
end

puts crawl('http://www.facebook.com/people/Anita-Briem/616302322')