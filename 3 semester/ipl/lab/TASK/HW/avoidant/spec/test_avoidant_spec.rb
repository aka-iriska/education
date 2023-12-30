require 'rails_helper'
require "json"
require "selenium-webdriver"
require "rspec-rails"

include RSpec::Expectations

describe "FilterPeople" do

  before(:each) do
    @driver = Selenium::WebDriver.for :edge
    @base_url = "https://www.google.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @base_wait = 0.15
  end

  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end

  it "test_filter_people" do
    sleep @base_wait
    @driver.get "http://127.0.0.1:3000/ru/create_post"
    sleep @base_wait
    @driver.find_element(:link, "Люди").click
    sleep @base_wait
    @driver.get "http://127.0.0.1:3000/ru/people"
    sleep @base_wait
    @driver.find_element(:xpath, "//html[@id='root']/body/div/div[2]/div/button").click
    sleep @base_wait
    @driver.find_element(:id, "man").click
    sleep @base_wait
    @driver.find_element(:id, "wrinkles").click
    sleep @base_wait
    @driver.find_element(:id, "facial_hair").click
    sleep @base_wait
    @driver.find_element(:name, "operation").click
    sleep @base_wait

    begin
      @driver.find_element(:xpath, "//div[@id='load_more_people_users']/form/button").click
      sleep 2
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      sleep 0.5
      retry
    end
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if @accept_next_alert
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end

describe "CreatePost" do

  before(:each) do
    @driver = Selenium::WebDriver.for :edge
    @base_url = "https://www.google.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @base_wait = 0.15
  end

  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end

  it "test_create_post" do
    # Нужно создать пользователя "pupkin@gmail.com" с паролем "123456"
    @driver.get "http://127.0.0.1:3000/ru/signin"
    sleep @base_wait
    @driver.find_element(:id, "session_email").clear
    @driver.find_element(:id, "session_email").send_keys "pupkin@gmail.com"
    sleep @base_wait

    @driver.find_element(:id, "session_password").clear
    @driver.find_element(:id, "session_password").send_keys "123456"
    sleep @base_wait

    @driver.find_element(:name, "login_btn").click
    sleep 2.0

    @driver.get "http://127.0.0.1:3000/ru/home"
    sleep @base_wait

    @driver.get "http://127.0.0.1:3000/ru/create_post"
    sleep @base_wait

    @driver.find_element(:id, "address").click
    @driver.find_element(:id, "address").clear
    @driver.find_element(:id, "address").send_keys "В России"
    sleep @base_wait

    @driver.find_element(:id, "wrinkles").click
    @driver.find_element(:id, "facial_hair").click
    @driver.find_element(:id, "hair_checkbox").click
    sleep @base_wait

    @driver.find_element(:id, "hair_color").clear
    @driver.find_element(:id, "hair_color").send_keys "#ffffff"
    sleep @base_wait

    @driver.find_element(:id, "height").click
    @driver.find_element(:id, "height").clear
    @driver.find_element(:id, "height").send_keys "150"
    sleep @base_wait

    @driver.find_element(:id, "age").click
    @driver.find_element(:id, "age").clear
    @driver.find_element(:id, "age").send_keys "150"
    sleep @base_wait

    @driver.find_element(:name, "find[race]").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "find[race]")).select_by(:text, "Европеоид")
    @driver.find_element(:name, "find[voice]").click

    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "find[voice]")).select_by(:text, "Тенор")
    @driver.find_element(:name, "find[ears]").click

    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "find[ears]")).select_by(:text, "Круглые")
    @driver.find_element(:name, "find[body_type]").click

    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "find[body_type]")).select_by(:text, "Эктоморф")
    @driver.find_element(:xpath, "//form[@id='new_people_find']/div").click

    @driver.find_element(:name, "find[forehead]").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:name, "find[forehead]")).select_by(:text, "Прямой скошенный")
    @driver.find_element(:xpath, "//button[@type='submit']").click
    @driver.find_element(:id, "flash-close").click

    sleep 2.0
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
