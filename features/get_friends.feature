# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

Scenario: Get Friends of Anita Briem
		When I feed openfacebook with "http://www.facebook.com/people/Anita-Briem/616302322" as "URL"
		Then I should get 8 random friends
		
		When I feed openfacebook with "riggasconi" as "vanity name"
		Then I should get 8 random friends

