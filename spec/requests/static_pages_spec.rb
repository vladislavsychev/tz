require 'spec_helper'

describe "StaticPages" do

subject { page }

  describe "Home page" do
  before { visit root_path }
   it { should have_selector('title',
                    :text => "TaxiZi") }
    
   it { should have_selector('h1',
                    :text => "TaxiZi") }
			
  end

  describe "Help page" do
  before { visit help_path}  
  
	it "should have content 'Help page'" do
		page.should have_selector('h1', :text => 'Help')
	end
	it "should have the right title" do
  		page.should have_selector('title',
                    :text => "TaxiZi | Help")
	 end
  end

  describe "About page" do
  before { visit about_path }
	it "should have content 'About'" do
		page.should have_selector('h1', :text => 'About')
	end
	it "should have the right title" do
  		page.should have_selector('title',
                    :text => "TaxiZi | About")
	end
  end

  describe "Contact page" do
  before { visit contact_path }
    it "should have correct h1 'Contact'" do
    	page.should have_selector('h1', text: 'Contact')
    end
    it "should have correct title" do
    	page.should have_selector('title', text: 'TaxiZi | Contact')
    end
  end
end
