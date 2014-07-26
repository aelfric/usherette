require 'test_helper'

class CartsControllerTest < ActionController::TestCase
    test "should show the current cart" do
        sign_out :user
        get :show, id: 1234 #id doesn't matter...SHOW should always point to current cart
    end
end
