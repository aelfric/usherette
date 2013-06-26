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
            
            redirect_using_post "https://www.sandbox.paypal.com/cgi-bin/webscr", 
                {"cmd" => "_s-xclick", "encrypted" => @current_cart.paypal_encrypted_url(performances_url, payment_notifications_url)}
        else
            render :edit
        end
    end
end
