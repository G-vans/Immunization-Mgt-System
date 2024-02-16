require "application_system_test_case"

class VaccinesTest < ApplicationSystemTestCase
  setup do
    @vaccine = vaccines(:one)
  end

  test "visiting the index" do
    visit vaccines_url
    assert_selector "h1", text: "Vaccines"
  end

  test "should create vaccine" do
    visit vaccines_url
    click_on "New vaccine"

    fill_in "Name", with: @vaccine.name
    fill_in "Status", with: @vaccine.status
    click_on "Create Vaccine"

    assert_text "Vaccine was successfully created"
    click_on "Back"
  end

  test "should update Vaccine" do
    visit vaccine_url(@vaccine)
    click_on "Edit this vaccine", match: :first

    fill_in "Name", with: @vaccine.name
    fill_in "Status", with: @vaccine.status
    click_on "Update Vaccine"

    assert_text "Vaccine was successfully updated"
    click_on "Back"
  end

  test "should destroy Vaccine" do
    visit vaccine_url(@vaccine)
    click_on "Destroy this vaccine", match: :first

    assert_text "Vaccine was successfully destroyed"
  end
end
