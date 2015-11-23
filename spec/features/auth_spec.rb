require 'spec_helper'
require 'rails_helper'

feature "Sign Up" do
  before :each do
    visit "/users/new"
  end

  scenario "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  scenario "takes a username and password" do
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  scenario "validates presence of a username" do
    click_button "Submit"
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Username can't be blank")
  end

  scenario "rejects a zero-length password" do
    fill_in "Username", with: "new_user"
    click_button "Submit"
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Password is too short")
  end

  scenario "validates that the password is at least 6 characters long" do
    fill_in "Username", with: 'ginger_baker'
    fill_in "Password", with: 'short'
    click_button 'Submit'
    expect(page).to have_content 'Sign Up'
    expect(page).to have_content 'Password is too short'
  end

  scenario "logs the user in and redirects them" do
    fill_in "Username", with: "new_user"
    fill_in "Password", with: "password"
    click_button "Submit"
    expect(page).to have_content "new_user"
    expect(page).not_to have_content "Sign Up"
  end
end

feature "Sign Out" do

end
#
# feature "the signup process" do
#
#   it "has a new user page"
#
#   feature "signing up a user" do
#
#     it "shows username on the homepage after signup"
#
#   end
#
# end
#
# feature "logging in" do
#
#   it "shows username on the homepage after login"
#
# end
#
# feature "logging out" do
#
#   it "begins with logged out state"
#
#   it "doesn't show username on the homepage after logout"
#
# end
