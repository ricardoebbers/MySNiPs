require 'test_helper'

class GenesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get genes_create_url
    assert_response :success
  end

end
