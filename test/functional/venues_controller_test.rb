require 'test_helper'

class VenuesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @venue = venues(:globe)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venue" do
    assert_difference('Venue.count') do
      post :create, venue: { capacity: @venue.capacity, city: @venue.city, name: @venue.name, state: @venue.state, street_address: @venue.street_address, zipcode: @venue.zipcode }
    end

    assert_redirected_to venue_path(assigns(:venue))
  end

  test "should show venue" do
    get :show, id: @venue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venue
    assert_response :success
  end

  test "should update venue" do
    put :update, id: @venue, venue: { capacity: @venue.capacity, city: @venue.city, name: @venue.name, state: @venue.state, street_address: @venue.street_address, zipcode: @venue.zipcode }
    assert_redirected_to venue_path(assigns(:venue))
  end

  test "should destroy venue" do
    assert_difference('Venue.count', -1) do
      delete :destroy, id: @venue
    end

    assert_redirected_to venues_path
  end
end
