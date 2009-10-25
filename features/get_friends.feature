# coding: utf-8

# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

Scenario: Actually get friends of Sebastiano
# to be decoupled

		When I feed openfacebook with "http://www.facebook.com/people/Sebastiano-Scrofina/560953853" as "url"
		Then I should get 8 random friends
		And I should get "560953853" as the returned "fbid"
		And I should get "riggasconi" as the returned "vanity"
		And I should get "http://www.facebook.com/people/Sebastiano-Scròfina/560953853" as the returned "url"
		And I should get "Sebastiano Scròfina" as the returned "name"
		
		When I feed openfacebook with "riggasconi" as "vanity"
		Then I should get 8 random friends
		And I should get "560953853" as the returned "fbid"
		And I should get "riggasconi" as the returned "vanity"
		And I should get "http://www.facebook.com/people/Sebastiano-Scròfina/560953853" as the returned "url"
		And I should get "Sebastiano Scròfina" as the returned "name"

		When I feed openfacebook with "560953853" as "fbid"
		Then I should get 8 random friends
		And I should get "560953853" as the returned "fbid"
		And I should get "riggasconi" as the returned "vanity"
		And I should get "http://www.facebook.com/people/Sebastiano-Scròfina/560953853" as the returned "url"
		And I should get "Sebastiano Scròfina" as the returned "name"