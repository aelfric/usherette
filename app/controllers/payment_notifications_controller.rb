class PaymentNotificationsController < ApplicationController
    protect_from_forgery :except => [:create]
    before_filter :authenticate_user!, :only => :index
    def create
        PaymentNotification.create!(:params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id] )
        @cart = Cart.find(params[:invoice])
        @cart.order_email = params[:payer_email]
        @cart.save
        render :nothing => true
    end

    def index
        @payment_notifications = PaymentNotification.all
    end
end
