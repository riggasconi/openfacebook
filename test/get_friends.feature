Feature: Get Friends
  In order to use the library
  The library
  Should be able to get friends
  
  Scenario: Get Friends Anita Briem
		Given the scene Default Configuration
		When I fill in "http://www.facebook.com/people/Anita-Briem/616302322"
		Then I should get 8 friends
