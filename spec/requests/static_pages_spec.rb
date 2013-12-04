require 'spec_helper'

describe "Static pages" do

	describe "Home page" do
  	
  		it "should have the content 'De kunst van het aanraken.'" do
  		  	visit '/static_pages/home'
    		expect(page).to have_content('De kunst van het aanraken.')
  		end
  		
	  	it "should have the title 'Home'" do
    		visit '/static_pages/home'
      		expect(page).to have_title("Home")
	    end
  	
  	end

end

