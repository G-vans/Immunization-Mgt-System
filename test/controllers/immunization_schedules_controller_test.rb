require "test_helper"

class ImmunizationSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @immunization_schedule = immunization_schedules(:one)
  end

  test "should get index" do
    get immunization_schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_immunization_schedule_url
    assert_response :success
  end

  test "should create immunization_schedule" do
    assert_difference("ImmunizationSchedule.count") do
      post immunization_schedules_url, params: { immunization_schedule: { child_id: @immunization_schedule.child_id, medic_id: @immunization_schedule.medic_id, scheduled_date: @immunization_schedule.scheduled_date, status: @immunization_schedule.status, vaxx_name: @immunization_schedule.vaxx_name } }
    end

    assert_redirected_to immunization_schedule_url(ImmunizationSchedule.last)
  end

  test "should show immunization_schedule" do
    get immunization_schedule_url(@immunization_schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_immunization_schedule_url(@immunization_schedule)
    assert_response :success
  end

  test "should update immunization_schedule" do
    patch immunization_schedule_url(@immunization_schedule), params: { immunization_schedule: { child_id: @immunization_schedule.child_id, medic_id: @immunization_schedule.medic_id, scheduled_date: @immunization_schedule.scheduled_date, status: @immunization_schedule.status, vaxx_name: @immunization_schedule.vaxx_name } }
    assert_redirected_to immunization_schedule_url(@immunization_schedule)
  end

  test "should destroy immunization_schedule" do
    assert_difference("ImmunizationSchedule.count", -1) do
      delete immunization_schedule_url(@immunization_schedule)
    end

    assert_redirected_to immunization_schedules_url
  end
end
