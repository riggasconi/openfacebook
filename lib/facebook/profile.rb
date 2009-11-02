class FacebookProfile
  
  # --to go into separate module?
  # take a hash (where there's either a facebook ID, a vanity name, or a URL)
  # and return a valid facebook public page URL
  def make_facebook_url(profile)
    return profile.url if profile.url
    return "http://www.facebook.com/#{profile.vanity}" if profile.vanity
    return "http://www.facebook.com/profile.php?id=#{profile.fbid}" if profile.fbid
  end
    
  # idea for decoupling the two make_facebook_url_ methods ?
  #[:id, :vanity].each do |type|
  # define_method 'make_facebook_url_'.add_to_symbol(type). do
  #
  # end
  #end
  
  attr_accessor :url, :fbid, :vanity, :name
  
  def initialize(hash)
    self.url= hash[:url]
    self.fbid= hash[:fbid]
    self.vanity= hash[:vanity]
    self.name= hash[:name]
  end

  def friends
    @friends= get_friends unless @friends
    @friends
  end 
  
  def trust(friend)
    result=0
    a_friends= self.friends; b_friends= friend.friends
    a_friends.each do |ak,av|
      b_friends.each {|bk,bv| result += 1 if av.fbid == bv.fbid}
    end
    (100.0/self.friends.size*result)
  end
  
  # overwrites self attributes (dangerous)
  def get
    self.fbid, self.vanity, self.name, self.url = self.get_page.personal_info
    return self
  end
  
  # validate: only if vanity is known / after #get()
  def twitter
    if self.vanity and not @twitter
      url= "http://www.twitter.com/#{self.vanity}"
      begin
        m= WWW::Mechanize.new.get(url)
        if m #and m.title.match(/#{self.name}/)
          @twitter= url 
        end
      rescue
        @twitter= nil
      end
    end
    @twitter
  end
  
  # return a scraped FacebookPage object
  def get_page
    url= make_facebook_url(self)
    return FacebookPage.new(url).scraped
  end
  
  private
  
  # should return array
  def get_friends
    result= {}; threads= []
    90.times do
      t= Thread.new do
        scrape_friends.each do |scraped_friend| 
          result[scraped_friend.name]= scraped_friend unless result[scraped_friend.name]
        end
      end
      threads << t
    end
    threads.each {|t| t.join}
    result
  end
  
  def scrape_friends
    result= []
    self.get_page.friends_data.each do |u,i,v,n|
      f= FacebookProfile.new(:url=>u, :fbid=>i,:vanity=>v,:name=>n)
      result << f
    end
    result
  end

  
end