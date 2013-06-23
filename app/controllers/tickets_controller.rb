class TicketsController < ApplicationController
    def create
        @cart = current_cart
        @ticket = @cart.add_ticket(params[:ticket][:performance_id], params[:ticket][:quantity])
        respond_to do |format|
            if @ticket.save
                format.html { redirect_to performances_path}
                format.json { render json: @ticket, status: :created, location: @ticket }
            else
                format.html { render action: "new" }
                format.json { render json: @ticket.errors, status: :unprocessable_entity }
            end
        end
    end
end
