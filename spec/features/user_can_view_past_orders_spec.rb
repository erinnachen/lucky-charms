require "rails_helper"

RSpec.feature "User can view past orders" do
  scenario "they see all orders belonging to them" do
    user = create(:user)
    order1 = user.orders.create(status: "ordered",
                                created_at: Time.new(2016, 3, 1))
    order2 = user.orders.create(status: "cancelled",
                                created_at: Time.new(2016, 3, 2))
    order3 = user.orders.create(status: "cancelled",
                                created_at: Time.new(2016, 3, 3))

    visit root_path
    first(:link, "Login").click
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Login to your account"

    visit "/orders"

    within ".orders" do
      expect(page).to have_content "##{order1.id}"
      expect(page).to have_content "ordered"
      expect(page).to have_content "March 1, 2016"

      expect(page).to have_content "##{order2.id}"
      expect(page).to have_content "cancelled"
      expect(page).to have_content "March 2, 2016"

      expect(page).to have_content "##{order3.id}"
      expect(page).to have_content "cancelled"
      expect(page).to have_content "March 3, 2016"
    end
  end

  context "visitor is not logged in" do
    scenario "they see landing page" do
      visit "/orders"

      expect(current_path).to eq(root_path)
    end
  end
end
