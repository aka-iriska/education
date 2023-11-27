# frozen_string_literal: true
require 'rails_helper'
require 'json'
require 'selenium-webdriver'
require 'rspec-rails'

include RSpec::Expectations

describe 'UntitledTestCase' do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = 'https://www.google.com/'
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  after(:each) do
    @driver.quit
    expect(@verification_errors).to match_array([])
  end

  it 'test_untitled_test_case' do
    values = ['1 2 3 4 5 6 1 2 3 1', '1 -1 2 3 1 4 6 1 2 3 4']
    targets = ['1 2 3 4 5 6', '1 2 3 4']

    values.length.times do |i|
      val = values[i]
      target = targets[i]
      @driver.get 'http://127.0.0.1:3000/'
      @driver.find_element(:id, 'str').click
      @driver.find_element(:id, 'str').clear
      @driver.find_element(:id, 'str').send_keys val
      @driver.find_element(:name, 'commit').click
      # Обрабатываем результат
      element = @driver.find_element(:id, 'result')
      text = element.text.split
      arr = ''
      iter = 0
      text.each do |num|
        break unless Integer(num, exception: false)
        arr += num + ' '
        iter += 1
      end
      arr += text[iter].chop
      verify { expect(arr).to match(target) }
    end
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify
    yield
  rescue ExpectationNotMetError => e
    @verification_errors << e
  end

  def close_alert_and_get_its_text(_how, _what)
    alert = @driver.switch_to.alert
    alert_text = alert.text
    if @accept_next_alert
      alert.accept
    else
      alert.dismiss
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end