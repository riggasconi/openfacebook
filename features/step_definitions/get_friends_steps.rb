# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

# adding the relative lib/ path
$: << File.expand_path(File.dirname('get_friends_steps.rb') + "../../lib")

require 'openfacebook'

When /^I feed openfacebook with "([^\"]*)" as "([^\"]*)"$/ do |content, type|
  @profile= FacebookProfile.new(type.to_sym => content)
end

Then /^I should get 8 random friends$/ do
  @profile.scrape_friends
  @profile.friends.size.should == 8
end

Then /^I should get "([^\"]*)" as the returned "([^\"]*)"$/ do |content, type|
  eval("@profile." + type) == content # is method #==() the best fit ?
end


