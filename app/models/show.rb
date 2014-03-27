class Show < ActiveRecord::Base
    has_many :performances
  attr_accessible :description, :title
  validates_presence_of :title
  validates_presence_of :description
  def description_to_html 
      return self.description.gsub("\n", "<br />").html_safe
  end
  
  def to_param
      "#{id}-#{title}".parameterize
  end
end
