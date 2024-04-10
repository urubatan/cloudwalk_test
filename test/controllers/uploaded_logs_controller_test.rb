require "test_helper"

class UploadedLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uploaded_log = uploaded_logs(:one)
  end

  test "should get index" do
    get uploaded_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_uploaded_log_url
    assert_response :success
  end

  test "should create uploaded_log" do
    assert_difference("UploadedLog.count") do
      post uploaded_logs_url, params: { uploaded_log: {  } }
    end

    assert_redirected_to uploaded_log_url(UploadedLog.last)
  end

  test "should show uploaded_log" do
    get uploaded_log_url(@uploaded_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_uploaded_log_url(@uploaded_log)
    assert_response :success
  end

  test "should update uploaded_log" do
    patch uploaded_log_url(@uploaded_log), params: { uploaded_log: {  } }
    assert_redirected_to uploaded_log_url(@uploaded_log)
  end

  test "should destroy uploaded_log" do
    assert_difference("UploadedLog.count", -1) do
      delete uploaded_log_url(@uploaded_log)
    end

    assert_redirected_to uploaded_logs_url
  end
end
