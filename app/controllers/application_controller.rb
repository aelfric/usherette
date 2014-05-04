class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :current_cart

    private
    def current_cart
        if session[:cart_id]
            @current_cart ||= Cart.find(session[:cart_id])
            session[:cart_id] = nil if @current_cart.purchased_at
        end

        if session[:cart_id].nil?
            @current_cart = Cart.create!
            session[:cart_id] ||= @current_cart.id
        end
        @current_cart
    rescue ActiveRecord::RecordNotFound
        @current_cart = Cart.create!
        session[:cart_id] = @current_cart.id
    end

    def redirect_using_post(url, params)
        render :text => %Q{<form action="#{url}">#{params.map{|k,v| %Q{<input type=
                                                               hidden" name="#{k}" value="#{v}" />}}.join('')}</form><script>document.forms[0].submit()</script>}
    end
end
