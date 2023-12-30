require "application_system_test_case"

class FindsTest < ApplicationSystemTestCase
  setup do
    @finds = people_finds(:one)
  end

  test "visiting the index" do
    visit people_finds_url
    assert_selector "h1", text: "Search requests"
  end

  test "should create search request" do
    visit people_finds_url
    click_on "New search request"

    fill_in "Address", with: @finds.address
    fill_in "Age", with: @finds.age
    fill_in "Body type", with: @finds.body_type
    fill_in "Conditions", with: @finds.conditions
    fill_in "Ears", with: @finds.ears
    check "Facial hair" if @finds.facial_hair
    fill_in "Gender", with: @finds.gender
    fill_in "Hair color", with: @finds.hair_color
    fill_in "Height", with: @finds.height
    fill_in "Race", with: @finds.race
    fill_in "Voice", with: @finds.voice
    check "Wrinkles" if @finds.wrinkles
    click_on "Create Search request"

    assert_text "Search request was successfully created"
    click_on "Back"
  end

  test "should update Search request" do
    visit people_finds_url(@finds)
    click_on "Edit this search request", match: :first

    fill_in "Address", with: @finds.address
    fill_in "Age", with: @finds.age
    fill_in "Body type", with: @finds.body_type
    fill_in "Conditions", with: @finds.conditions
    fill_in "Ears", with: @finds.ears
    check "Facial hair" if @finds.facial_hair
    fill_in "Gender", with: @finds.gender
    fill_in "Hair color", with: @finds.hair_color
    fill_in "Height", with: @finds.height
    fill_in "Race", with: @finds.race
    fill_in "Voice", with: @finds.voice
    check "Wrinkles" if @finds.wrinkles
    click_on "Update Search request"

    assert_text "Search request was successfully updated"
    click_on "Back"
  end

  test "should destroy Search request" do
    visit people_finds_url(@finds)
    click_on "Destroy this search request", match: :first

    assert_text "Search request was successfully destroyed"
  end
end
