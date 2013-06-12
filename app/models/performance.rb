class Performance < ActiveRecord::Base
  belongs_to :show
  belongs_to :venue
  attr_accessible :date, :show_id, :venue_id
end
