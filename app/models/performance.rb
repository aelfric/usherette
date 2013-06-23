class Performance < ActiveRecord::Base
  belongs_to :show
  belongs_to :venue
  has_many :tickets
  attr_accessible :date, :show_id, :venue_id, :price
  validates_presence_of :date
  validates_presence_of :venue_id
  validates_presence_of :price

  def price_string
      return "$%d.%02d" %  [self.price / 100, self.price % 100]
  end
  def date_string
      return self.date.strftime('%l:%M%p - %b %e')
  end
end
