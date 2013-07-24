class Ticket < ActiveRecord::Base
  belongs_to :cart
  belongs_to :performance
  attr_accessible :cart_id, :performance_id, :quantity
  def still_available?
      not self.performance.sold_out? and self.quantity <= self.performance.quantity_remaining
  end
end
