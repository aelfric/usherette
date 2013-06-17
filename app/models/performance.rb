class Performance < ActiveRecord::Base
  belongs_to :show
  belongs_to :venue
  has_many :tickets
  attr_accessible :date, :show_id, :venue_id, :price
  def price_string
      return "$%d.%02d" %  [self.price / 100, self.price % 100]
  end
  def date_string
      return self.date.strftime('%H:%M%p - %b %e')
  end
end
