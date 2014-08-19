class Show < ActiveRecord::Base
    has_many :performances
    attr_accessible :description, :title, :banner, :logo
    validates_presence_of :title
    validates_presence_of :description
    has_attached_file :banner, :styles => { :medium => "960x240>"}, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/
    has_attached_file :logo, :styles => { :medium => "480x240>"}, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/

    def to_param
        "#{id}-#{title}".parameterize
    end
end
