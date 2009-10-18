# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

require 'openfacebook' # is there a better way ?

When /^I feed openfacebook with "([^\"]*)"$/ do |url|
  @results= friends(url)
end

Then /^I should get 8 random friends$/ do
  @results.size.should == 8
end
