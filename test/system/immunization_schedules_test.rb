require "application_system_test_case"

class ImmunizationSchedulesTest < ApplicationSystemTestCase
  setup do
    @immunization_schedule = immunization_schedules(:one)
  end

  test "visiting the index" do
    visit immunization_schedules_url
    assert_selector "h1", text: "Immunization schedules"
  end

  test "should create immunization schedule" do
    visit immunization_schedules_url
    click_on "New immunization schedule"

    fill_in "Child", with: @immunization_schedule.child_id
    fill_in "Medic", with: @immunization_schedule.medic_id
    fill_in "Scheduled date", with: @immunization_schedule.scheduled_date
    check "Status" if @immunization_schedule.status
    fill_in "Vaxx name", with: @immunization_schedule.vaxx_name
    click_on "Create Immunization schedule"

    assert_text "Immunization schedule was successfully created"
    click_on "Back"
  end

  test "should update Immunization schedule" do
    visit immunization_schedule_url(@immunization_schedule)
    click_on "Edit this immunization schedule", match: :first

    fill_in "Child", with: @immunization_schedule.child_id
    fill_in "Medic", with: @immunization_schedule.medic_id
    fill_in "Scheduled date", with: @immunization_schedule.scheduled_date
    check "Status" if @immunization_schedule.status
    fill_in "Vaxx name", with: @immunization_schedule.vaxx_name
    click_on "Update Immunization schedule"

    assert_text "Immunization schedule was successfully updated"
    click_on "Back"
  end

  test "should destroy Immunization schedule" do
    visit immunization_schedule_url(@immunization_schedule)
    click_on "Destroy this immunization schedule", match: :first

    assert_text "Immunization schedule was successfully destroyed"
  end
end
