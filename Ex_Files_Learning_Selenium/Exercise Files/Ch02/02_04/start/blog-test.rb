require "selenium-webdriver"
require "selenium/server"
require "rspec"

# TEST: Sign up for blog
describe "Blog application:" do
  describe "signup to the blog application" do
      let(:target_directory) { File.join(Dir.tmpdir, SecureRandom.uuid) }
      let(:wait) { Selenium::WebDriver::Wait.new(timeout: 2) }
      let(:server) do
        Selenium::Server.get(:latest,
            background: true,
            args: %w[--selenium-manager true --enable-managed-downloads true])
    end
    let(:grid_url) { server.webdriver_url }
    it "confirm that a user can successfully signup" do
      	timestamp = Time.now.to_i
      	options = Selenium::WebDriver::Options.firefox
        driver = Selenium::WebDriver.for :remote, url: grid_url, options: options
      	# Go to signup form
		driver.navigate.to "https://selenium-blog.herokuapp.com/signup"
		# Fill out and submit form
		username_field = driver.find_element(id: 'user_username')
      	username_field.send_keys("user#{timestamp}")

      	email_field = driver.find_element(id: 'user_email')
      	email_field.send_keys("user#{timestamp}@test.com")

		password_field = driver.find_element(id: 'user_password')
		password_field.send_keys("password")

		sign_up_button = driver.find_element(id: 'submit')
		sign_up_button.click

		# Confirm user is signed up successfully
		banner = driver.find_element(id: 'flash_success')
		banner_text = banner.text
		expect(banner_text).to eq("Welcome to the alpha blog user#{timestamp}")

		driver.quit
	end
  end
end
