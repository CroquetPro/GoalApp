
def sign_up(user)
  visit "/users/new"
  fill_in "Username", with: user
  fill_in "Password", with: "password"
  click_button "Submit"
end

def sign_in(user)
  visit "/session/new"
  fill_in "Username", with: user
  fill_in "Password", with: "password"
  click_button "Submit"
end
