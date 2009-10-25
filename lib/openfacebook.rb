# coding: utf-8
# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

module Urlable
    
  # take a hash (where there's either a facebook ID, a vanity name, or a URL)
  # and return a valid facebook public page URL
  def Urlable.make_url_from(profile)
    return profile.url if profile.url
    return "http://www.facebook.com/#{profile.vanity}" if profile.vanity
    return "http://www.facebook.com/profile.php?id=#{profile.fbid}" if profile.fbid
  end
    
  # idea for decoupling the two make_url_from_ methods ?
  #[:id, :vanity].each do |type|
  # define_method 'make_url_from_'.add_to_symbol(type). do
  #
  # end
  #end
  
end

class FacebookProfile
  include Urlable
  
  attr_accessor :url, :fbid, :vanity, :name
  attr_writer :friends
  
  def initialize(hash)
    self.url= hash[:url]
    self.fbid= hash[:fbid]
    self.vanity= hash[:vanity]
    self.name= hash[:name]
  end
  
  # overwrites self attributes (dangerous)
  def get
    self.fbid, self.vanity, self.name, self.url = self.get_page.personal_info
    return self
  end
  
  def friends
    @friends= []
    scrape_friends
    @friends
  end
  
  # return a scraped FacebookPage object
  def get_page
    url= Urlable.make_url_from(self)
    return FacebookPage.new(url).scraped
  end
  
  private

  def scrape_friends
    self.get_page.friends_urls.each do |u|
      f= FacebookProfile.new(:url=>u)
      @friends << f
    end
  end

  
end

class FacebookPage

  require 'rubygems'
  require 'mechanize'

  attr_accessor :mechanize
  attr_writer :url
  
  def initialize(url)
    self.url= url
  end
  
  def scraped
    m= WWW::Mechanize.new
    m.get(self.url)
    self.mechanize= m
    return self
  end
  
  # returns [fbid, vanity, name, url]
  def personal_info
    [fbid, vanity, name, url]
  end
  
  # extract friends Nokogiri objects from the Nokogiri page object
  def friends_urls
    friends_urls= []
    self.mechanize.page.search(%|a[@rel="friend"]|).each do |e| 
      friends_urls << extract_url(e)
    end
    friends_urls.uniq # needs .uniq because links are coupled in facebook page
  end
  
  def url
    if self.mechanize
      return self.mechanize.history[0].uri.to_s 
    else
      return @url
    end
  end
  
  def fbid
    dirty= self.mechanize.page.search(%|[@class="logged_out_register_subhead"]|).search("a").to_s
    clean= dirty.match(/;fid=\d*&/).to_s.sub(';fid=','').sub('&','')
    clean
  end
  
  def vanity
    path= self.mechanize.history[0].uri.path.dup
    path.to_s.slice!(0)
    return path if not path.match(/\//)
    return nil if path.match(/\//)
  end
  
  def name
    self.mechanize.page.title.sub(' | Facebook','').sub(/ - .*/,'')
  end
  
  # extract the URL as string from the Nokogiri object
  def extract_url(element)
    element.attributes['href'].to_s
  end
  
end