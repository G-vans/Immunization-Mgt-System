require "application_system_test_case"

class EducationalMessagesTest < ApplicationSystemTestCase
  setup do
    @educational_message = educational_messages(:one)
  end

  test "visiting the index" do
    visit educational_messages_url
    assert_selector "h1", text: "Educational messages"
  end

  test "should create educational message" do
    visit educational_messages_url
    click_on "New educational message"

    fill_in "Category", with: @educational_message.category
    fill_in "Content", with: @educational_message.content
    fill_in "Duration", with: @educational_message.duration
    fill_in "Medic", with: @educational_message.medic_id
    fill_in "Title", with: @educational_message.title
    click_on "Create Educational message"

    assert_text "Educational message was successfully created"
    click_on "Back"
  end

  test "should update Educational message" do
    visit educational_message_url(@educational_message)
    click_on "Edit this educational message", match: :first

    fill_in "Category", with: @educational_message.category
    fill_in "Content", with: @educational_message.content
    fill_in "Duration", with: @educational_message.duration
    fill_in "Medic", with: @educational_message.medic_id
    fill_in "Title", with: @educational_message.title
    click_on "Update Educational message"

    assert_text "Educational message was successfully updated"
    click_on "Back"
  end

  test "should destroy Educational message" do
    visit educational_message_url(@educational_message)
    click_on "Destroy this educational message", match: :first

    assert_text "Educational message was successfully destroyed"
  end
end
