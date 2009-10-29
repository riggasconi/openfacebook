# coding: utf-8
# author: Sebastiano Scròfina (http://www.riggasconi.com)
# this code is released under the Ruby License

# adding the relative lib/ path
$: << File.expand_path(File.dirname('get_friends_steps.rb') + "../../lib")

require 'openfacebook'

When /^I feed openfacebook with "([^\"]*)" as "([^\"]*)"$/ do |content, type|
  @profile= FacebookProfile.new(type.to_sym => content).get
end

Then /^I should get some 200 friends$/ do
  @profile.friends.size.should > 200
end

Then /^I should get "([^\"]*)" as fbid$/ do |arg1|
  @profile.fbid.should == arg1
end

Then /^I should get "([^\"]*)" as vanity$/ do |arg1|
  @profile.vanity.should == arg1
end

Then /^I should get "([^\"]*)" as url$/ do |arg1|
  @profile.url.should == arg1
end

Then /^I should get "([^\"]*)" as name$/ do |arg1|
  @profile.name.should == arg1
end