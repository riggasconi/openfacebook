# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

Scenario: Get Friends of Sebastiano

		When I feed openfacebook with "http://www.facebook.com/people/Sebastiano-Scr%F2fina/560953853" as "url"
		Then I should get 8 random friends
		And I should get "560953853" as the returned ID
		
		When I feed openfacebook with "riggasconi" as "vanity"
		Then I should get 8 random friends
		And I should get "560953853" as the returned ID

		When I feed openfacebook with "560953853" as "id"
		Then I should get 8 random friends
		And I should get "560953853" as the returned ID


