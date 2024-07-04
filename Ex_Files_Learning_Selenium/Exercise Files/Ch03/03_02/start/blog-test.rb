require "selenium-webdriver"
require "selenium/server"
require "rspec"

timestamp = Time.now.to_i
username = "user#{timestamp}"
email = "user#{timestamp}@test.com"
password = "password"
expected_banner_text = "Welcome to the alpha blog user#{timestamp}"

def enter_username(username)
    username_field = @driver.find_element(id: 'user_username')
    username_field.send_keys(username)
end

def enter_email(email)
    email_field = @driver.find_element(id: 'user_email')
    email_field.send_keys(email)
end

def enter_password(password)
    password_field = @driver.find_element(id: 'user_password')
    password_field.send_keys(password)
end

def click_signup()
    sign_up_button = @driver.find_element(id: 'submit')
    sign_up_button.click
end

def get_banner_text()
    banner = @driver.find_element(id: 'flash_success')
    banner_text = banner.text
end

# TEST: sign up for blog
describe "Blog application" do
  describe "when signing up a new user" do
      let(:target_directory) { File.join(Dir.tmpdir, SecureRandom.uuid) }
        let(:wait) { Selenium::WebDriver::Wait.new(timeout: 2) }
        let(:server) do
          Selenium::Server.get(:latest,
              background: true,
              args: %w[--selenium-manager true --enable-managed-downloads true])
      end
      let(:grid_url) { server.webdriver_url }
      it "confirm that a user can successfully signup" do
          options = Selenium::WebDriver::Options.firefox
          @driver = Selenium::WebDriver.for :remote, url: grid_url, options: options

      # Go to signup form
      @driver.navigate.to "https://selenium-blog.herokuapp.com/signup"

      # Fill out and submit form
      enter_username(username)
      enter_email(email)
      enter_password(password)
      click_signup()

      # Confirm user is signed up successfully
      banner_text = get_banner_text()
      expect(banner_text).to eq(expected_banner_text)

      @driver.quit
    end
  end
end
