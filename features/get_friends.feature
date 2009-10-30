# coding: utf-8
# author: Sebastiano Scròfina (http://www.riggasconi.com)
# this code is released under the Ruby License

Scenario: Get friends by url
# to be decoupled

		When I feed openfacebook with "http://www.facebook.com/people/Sebastiano-Scrofina/560953853" as "url"
		Then I should get some 200 friends
		And I should get "560953853" as fbid
		And I should get "riggasconi" as vanity
		And I should get "http://www.facebook.com/riggasconi" as url
		And I should get "Sebastiano Scròfina" as name

Scenario: Get friends by vanity name

		When I feed openfacebook with "riggasconi" as "vanity"
		Then I should get some 200 friends
		And I should get "560953853" as fbid
		And I should get "riggasconi" as vanity
		And I should get "http://www.facebook.com/riggasconi" as url
		And I should get "Sebastiano Scròfina" as name

Scenario: Get friends by facebook ID

		When I feed openfacebook with "560953853" as "fbid"
		Then I should get some 200 friends
		And I should get "560953853" as fbid
		And I should get "riggasconi" as vanity
		And I should get "http://www.facebook.com/riggasconi" as url
		And I should get "Sebastiano Scròfina" as name
		
		# add a user who joined a network
