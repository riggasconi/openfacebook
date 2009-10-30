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
  
  def friends_data
    friends_data= []
    self.mechanize.page.search(%|a[@rel="friend"]|).each do |f| 
      friends_data << [extract_url(f), extract_fbid(f), extract_vanity(f), extract_name(f)]
    end
    friends_data.uniq # needs .uniq because links are coupled in facebook page
    friends_data.delete_if {|f| f[1]==nil}
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
  
  # extract the name as string from the Nokogiri object
  def extract_name(element)
    element.attributes['title'].to_s
  end
  
  # extract the ID as string from the Nokogiri object
  def extract_fbid(element)
    begin
      result= element.search(%|[@alt]|).attr('src').match(/q\d*_/).to_s.sub('q','').sub('_','')
    rescue
      result=nil
    end
    return result
  end

  # test thouroughly: there are some issues in facebook's responses
  # extract the vanity name as string from the Nokogiri object
  def extract_vanity(element)
    result=nil
    path= element.attributes['href'].to_s.sub!(/.*facebook.com\//,'')
    if path
      result= path if not path.match(/\//)
      result= nil if path.match(/\//)
    end
    return result
  end
  
end