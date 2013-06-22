class CartsController < ApplicationController
    def show
        @cart = current_cart
    end

    def edit
    end

    def update
        @cart = current_cart
        if @cart.update_attributes(params[:cart])
            @cart.placed_at = Time.now()
            @cart.save
            redirect_to @cart.paypal_url(performances_url, payment_notifications_url)
        else
            render :edit
        end
    end
end
