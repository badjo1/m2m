require 'spec_helper'

describe "User pages" do

  subject { page }
    
  describe "index" do
	let(:user) { FactoryGirl.create(:party) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:party) } }
      after(:all)  { Party.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        Party.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

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
  
  
  describe "edit" do
    let(:party) { FactoryGirl.create(:party) }
    before do
      sign_in party
	  visit edit_user_path(party)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
    
     describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: party.password
        fill_in "Confirm Password", with: party.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(party.reload.name).to  eq new_name }
      specify { expect(party.reload.email).to eq new_email }
    end
  end
end
