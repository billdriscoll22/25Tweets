require "rails_helper"

describe "Users" do
  before do
    User.create!(email: "foo@bar.com", password: "12345678")
  end

  describe "signing in" do
    describe "with correct credentials" do
      before do
        login("foo@bar.com", "12345678")
      end

      it "logs in successfully" do
        expect(page).to have_content("foo@bar.com")
        expect(page).to have_content("Logout")
        # REST
        expect(current_path).to eq("/tweets")
      end
    end

    describe "with incorrect credentials" do
      before do
        login("foo@bar.com", "123456799")
      end

      it "does not log in successfully" do
        expect(page).not_to have_content("foo@bar.com")
        expect(page).not_to have_content("Logout")
        expect(current_path).to eq("/users/sign_in")
      end
    end
  end



  def login(email, password)
    visit "/users/sign_in"
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button "Log in"
  end
end
