require "test_helper"

class EducationalMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @educational_message = educational_messages(:one)
  end

  test "should get index" do
    get educational_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_educational_message_url
    assert_response :success
  end

  test "should create educational_message" do
    assert_difference("EducationalMessage.count") do
      post educational_messages_url, params: { educational_message: { category: @educational_message.category, content: @educational_message.content, duration: @educational_message.duration, medic_id: @educational_message.medic_id, title: @educational_message.title } }
    end

    assert_redirected_to educational_message_url(EducationalMessage.last)
  end

  test "should show educational_message" do
    get educational_message_url(@educational_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_educational_message_url(@educational_message)
    assert_response :success
  end

  test "should update educational_message" do
    patch educational_message_url(@educational_message), params: { educational_message: { category: @educational_message.category, content: @educational_message.content, duration: @educational_message.duration, medic_id: @educational_message.medic_id, title: @educational_message.title } }
    assert_redirected_to educational_message_url(@educational_message)
  end

  test "should destroy educational_message" do
    assert_difference("EducationalMessage.count", -1) do
      delete educational_message_url(@educational_message)
    end

    assert_redirected_to educational_messages_url
  end
end
