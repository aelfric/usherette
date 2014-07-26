require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
    test "should add ticket to cart" do
        @performance = performances(:one)
        assert_difference('Ticket.count', 1) do
            post :create, ticket: {performance_id: @performance.id, quantity: 1}
        end
    end

    test "should remove ticket from cart" do
        @performance = performances(:one)
        assert_difference('Ticket.count', 1) do
            post :create, ticket: {performance_id: @performance.id, quantity: 1}
        end
        ticket = Ticket.last
        assert_difference('Ticket.count', -1) do
            delete :destroy, id: ticket.id 
            assert_response :redirect
        end
    end
end
