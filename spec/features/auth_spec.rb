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
  before :each do
    sign_up("new_user")
  end

  scenario "Has a sign out button" do
    expect(page).to have_button "Sign Out"
  end

  scenario "logs the user out and redirects them to the sign in page" do
    click_button "Sign Out"
    expect(page).to have_content "Sign In"
    expect(page).not_to have_content "new_user"
  end
end

feature "Sign In" do
  before :each do
    visit "/session/new"
  end

  scenario "has a sign in page" do
    expect(page).to have_content "Sign In"
  end

  scenario "takes a username and password" do
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  scenario "rerenders sign in on failure and saves username if present" do
    fill_in "Username", with: "user"
    click_button "Submit"
    expect(page).to have_content "Sign In"
    expect(find_field('Username').value).to eq("user")
  end

  scenario "takes user to goals page" do
    sign_up("user")
    click_button "Sign Out"
    sign_in("user")
    expect(page).to have_content "user"
    expect(page).to have_content "Goals"
    expect(page).not_to have_content "Sign In"
  end
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
