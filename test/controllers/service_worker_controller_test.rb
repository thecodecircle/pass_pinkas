require 'test_helper'

class ServiceWorkerControllerTest < ActionDispatch::IntegrationTest
  test "should get service_worker" do
    get service_worker_service_worker_url
    assert_response :success
  end

  test "should get manifest" do
    get service_worker_manifest_url
    assert_response :success
  end

end
