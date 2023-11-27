require "application_system_test_case"

class ChislaResultsTest < ApplicationSystemTestCase
  setup do
    @chisla_result = chisla_results(:one)
  end

  test "visiting the index" do
    visit chisla_results_url
    assert_selector "h1", text: "Chisla results"
  end

  test "should create chisla result" do
    visit chisla_results_url
    click_on "New chisla result"

    fill_in "My table", with: @chisla_result.my_table
    fill_in "Result", with: @chisla_result.result
    fill_in "String", with: @chisla_result.string
    click_on "Create Chisla result"

    assert_text "Chisla result was successfully created"
    click_on "Back"
  end

  test "should update Chisla result" do
    visit chisla_result_url(@chisla_result)
    click_on "Edit this chisla result", match: :first

    fill_in "My table", with: @chisla_result.my_table
    fill_in "Result", with: @chisla_result.result
    fill_in "String", with: @chisla_result.string
    click_on "Update Chisla result"

    assert_text "Chisla result was successfully updated"
    click_on "Back"
  end

  test "should destroy Chisla result" do
    visit chisla_result_url(@chisla_result)
    click_on "Destroy this chisla result", match: :first

    assert_text "Chisla result was successfully destroyed"
  end
end
