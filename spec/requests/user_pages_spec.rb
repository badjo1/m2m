require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:party) { FactoryGirl.create(:party) }
    before { visit user_path(party) }

    it { should have_content(party.name) }
    it { should have_title(party.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
  
  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(Party, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(Party, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:party) { Party.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(party.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      
    end
  end
  
  
end
