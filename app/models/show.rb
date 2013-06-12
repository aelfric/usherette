class Show < ActiveRecord::Base
    has_many :performances
  attr_accessible :description, :title
end
