module Urlizer
    
  # take a hash (where there's either a facebook ID, a vanity name, or a URL)
  # and return a valid facebook public page URL
  def Urlizer.make_facebook_url(profile)
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
  
end