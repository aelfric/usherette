require 'test_helper'

class PerformancesControllerTest < ActionController::TestCase
    setup :initialize_user


  test "should get new" do
    get :new, show_id: shows(:hamlet).id
    assert_response :success
  end

  test "should get create" do
      assert_difference('Performance.count', 1) do
          assert_not_nil shows(:hamlet)
          assert_not_nil venues(:globe)
          post :create, performance: {show_id: shows(:hamlet).id, 
                                      venue_id: venues(:globe).id, 
                                      date: '2014-12-01 20:00:00',
                                      price: 2000,
                                      delivery_type: :will_call}
          assert_response :redirect
      end
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  private
    def initialize_user 
        @user = users(:one)
        sign_in @user
    end
end
