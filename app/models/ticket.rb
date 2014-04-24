class Ticket < ActiveRecord::Base
  belongs_to :cart
  has_one :payment_notification, :through => :cart
  belongs_to :performance
  attr_accessible :cart_id, :performance_id, :quantity
  def still_available?
      self.performance.date >= Date.today and not self.performance.sold_out? and self.quantity <= self.performance.quantity_remaining
  end
end
