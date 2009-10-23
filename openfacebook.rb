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
  page.search(%|a[@rel="friend"@]|).each {|e| friends_urls << extract_url(e)}
  friends_urls.uniq #xpath issue, gotta check also class="title"
end

# take a a facebook vanity name
# and return a valid facebook public page URL
def make_url_from_vanity(string)
  "http://www.facebook.com/#{string}"
end

# take a a facebook ID
# and return a valid facebook public page URL
def make_url_from_id(string)
  "http://www.facebook.com/profile.php?id=#{string}"
end

# idea for decoupling the two make_url_from_ methods ?
#[:id, :vanity].each do |type|
# define_method 'make_url_from_'.add_to_symbol(type). do
#
# end
#end

# take a hash (where there's either a facebook ID, a vanity name, or a URL)
# and return a valid facebook public page URL
def make_url(hash)
  return hash[:url] if hash[:url]
  return make_url_from_vanity(hash[:vanity]) if hash[:vanity]
  return make_url_from_id(hash[:id]) if hash[:id]
end

# take a URL string and return an array of friends URLs
def get(hash)
  url= make_url(hash)
  page= open_page(url)
  persona= {:friends => extract_friends_for(page), :id => 560953853}
end