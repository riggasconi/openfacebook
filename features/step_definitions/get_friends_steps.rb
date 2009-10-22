# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

require 'openfacebook' # is there a better way ?

When /^I feed openfacebook with "([^\"]*)" as "([^\"]*)"$/ do |content, type|
  @results= get(type.to_sym => content)
end

Then /^I should get 8 random friends$/ do
  @results[:friends].size.should == 8
end

Then /^I should get "([^\"]*)" as the returned ID$/ do |id|
  @results[:id].should == id.to_i
end


