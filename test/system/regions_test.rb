require "application_system_test_case"

class RegionsTest < ApplicationSystemTestCase
  setup do
    @region = regions(:one)
  end

  test "visiting the index" do
    visit regions_url
    assert_selector "h1", text: "Regions"
  end

  test "creating a Region" do
    visit regions_url
    click_on "New Region"

    fill_in "Movement", with: @region.movement_id
    fill_in "Name", with: @region.name
    fill_in "Score", with: @region.score
    click_on "Create Region"

    assert_text "Region was successfully created"
    click_on "Back"
  end

  test "updating a Region" do
    visit regions_url
    click_on "Edit", match: :first

    fill_in "Movement", with: @region.movement_id
    fill_in "Name", with: @region.name
    fill_in "Score", with: @region.score
    click_on "Update Region"

    assert_text "Region was successfully updated"
    click_on "Back"
  end

  test "destroying a Region" do
    visit regions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Region was successfully destroyed"
  end
end
