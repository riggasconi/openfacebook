# coding: utf-8
# author: Sebastiano Scròfina (riggasconi@kaaaki.com)
# this code is released under the Ruby License

Scenario: Get friends
# to be decoupled

		When I feed openfacebook with "http://www.facebook.com/people/Sebastiano-Scrofina/560953853" as "url"
		Then I should get 8 random friends
		And I should get "560953853" as fbid
		And I should get "riggasconi" as vanity
		And I should get "http://www.facebook.com/riggasconi" as url
		And I should get "Sebastiano Scròfina" as name
		
		When I feed openfacebook with "riggasconi" as "vanity"
		Then I should get 8 random friends
		And I should get "560953853" as fbid
		And I should get "riggasconi" as vanity
		And I should get "http://www.facebook.com/riggasconi" as url
		And I should get "Sebastiano Scròfina" as name

		When I feed openfacebook with "560953853" as "fbid"
		Then I should get 8 random friends
		And I should get "560953853" as fbid
		And I should get "riggasconi" as vanity
		And I should get "http://www.facebook.com/riggasconi" as url
		And I should get "Sebastiano Scròfina" as name
		
		# a user who joined a network
		When I feed openfacebook with "andrealamesa" as "vanity"
		Then I should get 8 random friends
		And I should get "??????" as fbid
		And I should get "andrealamesa" as vanity
		And I should get "http://www.facebook.com/andrealamesa" as url
		And I should get "Andrea La Mesa" as name
		
Scenario: Fail to get friends