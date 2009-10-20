# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

require 'openfacebook' # is there a better way ?

When /^I feed openfacebook with "([^\"]*)" as "([^\"]*)"$/ do |content, type|
  @results= friends(type.to_sym => content)
end

Then /^I should get 8 random friends$/ do
  @results.size.should == 8
end
