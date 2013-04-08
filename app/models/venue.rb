class Venue < ActiveRecord::Base
  attr_accessible :capacity, :city, :name, :state, :street_address, :zipcode
end
