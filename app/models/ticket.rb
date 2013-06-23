class Ticket < ActiveRecord::Base
  belongs_to :cart
  belongs_to :performance
  attr_accessible :cart_id, :performance_id, :quantity
end
