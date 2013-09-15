class Performance < ActiveRecord::Base
  belongs_to :show
  belongs_to :venue
  has_many :tickets
  attr_accessible :date, :show_id, :venue_id, :price, :delivery_type
  validates_presence_of :date
  validates_presence_of :venue_id
  validates_presence_of :price
  as_enum :delivery_type, :will_call => 0, :mail => 1

  def price_string
      return "$%d.%02d" %  [self.price / 100, self.price % 100]
  end
  def date_string
      return self.date.strftime('%l:%M%p - %b %e')
  end
  def sold_out?
      return self.quantity_sold >= self.venue.capacity
  end
  def quantity_sold
      total = 0
      self.tickets.each do |t|
          if t.cart.purchased_at?
              total += t.quantity
          end
      end
      total
  end
  def quantity_remaining
      self.venue.capacity - self.quantity_sold
  end
end
