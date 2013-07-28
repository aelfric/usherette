class MessagesController < ApplicationController
  def new
      @message = Message.new
  end

  def create
      @message = Message.new(params['message'])
      if @message.valid?
          ContactUs.message_email(@message).deliver
      else
          render 'new'
      end
  end
end
