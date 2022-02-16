require 'rails_helper'


RSpec.describe "Users", type: :feature do
  def seed_users
    agency1 = User.create!({email: "agency1@abrodie.com", password: "123456", password_confirmation: "123456"})
    agency = agency1.create_agency!({
      name: "Brodie's Agency",
      verified: true,
      kind: "private",
      license_validity: DateTime.current + 700,
      contact_no: "09165555555",
      address: "2401 Taft Ave, Manila"
    })
    applicant1 = User.create!({email: "applicant1@abrodie.com", password: "123456", password_confirmation: "123456"})
    applicant = applicant1.create_applicant!({
      fname: "Spongebob",
      lname: "Squarepants",
      educational_level: "High school graduate",
      birth_date: DateTime.new(1997, 8, 29),
      specialization: "Cook"
    })
  end

  describe "on applicant sign up" do
    before {seed_users}
    before {visit root_path}
    before {click_link("EMPLOYEE")}

    it "sees the page" do
      expect(page).to have_content("Create an Account")
    end

    it "returns an error on duplicate email address" do
      fill_in "user[email]", with: "applicant1@abrodie.com"
      fill_in "user[password]", with: "123456"
      fill_in "user[password_confirmation]", with: "123456"

      fill_in "user[applicant_attributes][fname]", with: "DSSS"
      fill_in "user[applicant_attributes][lname]", with: "FSAD"

      click_button("Sign up")
      expect(page).to have_content("Email has already been taken")
    end

    it "rejects files that are not jpg/png" do
      fill_in "user[email]", with: "applicant2@abrodie.com"
      fill_in "user[password]", with: "123456"
      fill_in "user[password_confirmation]", with: "123456"

      fill_in "user[applicant_attributes][fname]", with: "DSSS"
      fill_in "user[applicant_attributes][lname]", with: "FSAD"

      attach_file("Avatar", Rails.root + "spec/fixtures/files/file.doc")
      click_button("Sign up")
      expect(page).to have_content("Kamusta")
    end

    it "redirects to guidelines page on sign up" do
      fill_in "user[email]", with: "applicant2@abrodie.com"
      fill_in "user[password]", with: "123456"
      fill_in "user[password_confirmation]", with: "123456"

      fill_in "user[applicant_attributes][fname]", with: "DSSS"
      fill_in "user[applicant_attributes][lname]", with: "FSAD"

      click_button("Sign up")
      expect(page).to have_content("Kamusta")
    end
  end
end
#   def admin_log_in
#     visit root_path
#     click_link('Sign in')
#     fill_in "user[email]", with: "cc@avion.com"
#     fill_in "user[password]", with: "kristocurrency"

#     click_button('Log in')
#   end

#   def fill_order(type, quantity)
#     fill_in "#{type}_order_quantity", with: "#{quantity}"
#     click_button("#{type.capitalize}")
#   end

#   describe "on visit" do
#     before {seed_users}
#     before {seed_coins}
#     before {admin_log_in}
#     before {visit trade_path("BTC")}

#     it "shows coins index" do
#       expect(find('div.trades-index-container')).to be_truthy
#     end
    
#     it "shows initial money" do
#       expect(page).to have_content("5000")
#     end
#   end
  
#   describe "On creation of order" do
#     before {seed_users}
#     before {seed_coins}
#     before {admin_log_in}
#     before {visit trade_path("BTC")}


#     it "shows a buy order created" do 
#       fill_order("buy", 0.01)
#       expect(page).to have_selector('.order-item-container', count: 2)
#     end

#     it "shows a sell order created" do
#       fill_order("buy", 0.01)
#       fill_order("sell", 0.01)
#       expect(page).to have_selector('.order-item-container', count: 3)
#     end

#     it "shows error message" do
#       fill_order("buy", 1)
#       expect(page).to have_content("insufficient balance")
#     end
#   end
# end