class TicketsController < ApplicationController
    def create
        @ticket = @current_cart.add_ticket(params[:ticket][:performance_id], params[:ticket][:quantity])
        respond_to do |format|
            if @ticket.save
                format.html { redirect_to performances_path, :notice => "Thank you. Your tickets have been added to your cart."}
                format.json { render json: @ticket, status: :created, location: @ticket }
            else
                format.html { render action: "new" }
                format.json { render json: @ticket.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @ticket = Ticket.find(params[:id])
        if @ticket.cart == current_cart
            @ticket.destroy
            redirect_to edit_cart_url(current_cart), :notice => 'These tickets have been removed from your cart.'
        else
            redirect_to edit_cart_url(current_cart), :notice => 'Sorry, an error occurred.  Please try again.'
        end
    end
end
