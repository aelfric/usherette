class Show < ActiveRecord::Base
    has_many :performances
    attr_accessible :description, :title, :banner
    validates_presence_of :title
    validates_presence_of :description
    has_attached_file :banner, :styles => { :medium => "960x240>"}, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/

    def description_to_html 
        return self.description.gsub("\n", "<br />").html_safe
    end

    def to_param
        "#{id}-#{title}".parameterize
    end
end
