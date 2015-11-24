require 'rails_helper'

feature "Displays for goals" do
  let(:user) { FactoryGirl.create(:user) }

  feature "Goal Index" do
    let!(:private_goal) { FactoryGirl.create(:goal, user_id: user.id, privacy: "Private") }
    let!(:public_goal) { FactoryGirl.create(:goal, user_id: user.id) }

    before :each do
      sign_in(user.username)
    end

    scenario "has a link to make a new goal" do
      expect(page).to have_link "New Goal"
    end

    scenario "displays all current user's goals" do
      expect(page).to have_content(private_goal.title)
      expect(page).to have_content(public_goal.title)
    end

    context "sign in a different user" do
      before :each do
        click_button "Sign Out"
        sign_up("new_user")
      end

      scenario "displays all of others' public goals, not private goals" do
        expect(page).to have_content(public_goal.title)
        expect(page).not_to have_content(private_goal.title)
      end
    end

    scenario "each item links to the goal show page" do
      click_link "#{public_goal.title}"
      expect(page).to have_content(public_goal.description)
    end
  end
end

feature "Creating Goals" do
  before :each do
    sign_up("new")
    visit "/goals/new"
  end

  scenario "takes title, description and privacy" do
    expect(page).to have_content "Title"
    expect(page).to have_content "Description"
    expect(page).to have_content "Privacy"
  end
end
