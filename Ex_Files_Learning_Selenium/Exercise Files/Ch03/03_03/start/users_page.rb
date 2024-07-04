class UsersPage

#css selectors
BANNER_TEXT = {id: 'flash_success'}

attr_reader :driver

#class methods
def initialize(driver)
    @driver = driver
end

def get_banner_text()
  banner = @driver.find_element(BANNER_TEXT)
  banner.text
end

end
