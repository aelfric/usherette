class CartsController < ApplicationController
    def show
        @cart = current_cart
    end

    def edit
    end

    def update
        @cart = current_cart
        if @cart.update_attributes(params[:cart].merge(:placed_at => Time.now()))
            @cart.save
            redirect_to APP_CONFIG[:paypal_url]+ "?"+ {"cmd" => "_s-xclick", "encrypted" => @current_cart.paypal_encrypted_url(performances_url, payment_notifications_url)}.to_query
        else
            render :edit
        end
    end
end
