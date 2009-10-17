# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

Feature: Get Friends
	In order test openfacebook
	As a rubyist
	I want check if openfacebook can GET friends
  
	Scenario: Get Friends of Anita Briem
		Given the scene Default Configuration
		When I feed openfacebook with "http://www.facebook.com/people/Anita-Briem/616302322"
		Then I should get 8 random friends
