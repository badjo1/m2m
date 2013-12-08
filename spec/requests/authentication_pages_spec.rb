require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
	
	describe "with invalid information" do
      before { click_button "Sign in" }
	  it { should have_content('Sign in') }
    
      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
        
    describe "with valid information" do
      let(:party) { FactoryGirl.create(:party) }
      before do
        fill_in "Email",    with: party.email.upcase
        fill_in "Password", with: party.password
        click_button "Sign in"
      end

      it { should have_title(party.name) }
      it { should have_link('Profile',     href: user_path(party)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
      
    end 
  end
    
end