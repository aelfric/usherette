class CartsController < ApplicationController
    before_filter :authenticate_user!, :only => [:create]
    def create
        @cart = Cart.new(params['cart'])
        @show = Show.find(params['show_id'])
        @cart.placed_at = Date.today
        if not @cart.save
            render 'shows/reserve' and return
        else
            params['perf'].each_with_index do |perf, i|
                if params['qty'][i].to_i > 0 
                    @cart.add_ticket(perf,params['qty'][i]).save
                end
            end
            @cart.purchased_at = Date.today
            if not @cart.save
                render 'shows/reserve'
            else
                @cart.reload
            end
        end
    end

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
