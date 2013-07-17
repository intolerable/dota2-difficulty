class Hero < ActiveRecord::Base

  belongs_to :upper, class_name: "EloInstance"
  belongs_to :lower, class_name: "EloInstance"

  validates :name, :slug,
    presence: true,
    uniqueness: true
  validates :upper, :lower,
    presence: true
  validates :upper_id, :lower_id,
    uniqueness: true

  before_validation do |r|
    r.slug = r.name.try :parameterize
    r.build_upper
    r.build_lower
  end

  def name_escaped
    self.name.gsub " ", "_"
  end

  def icon_path
    "/assets/hero_icons/crushed/#{self.name_escaped}.jpg"
  end

  def to_param
    self.slug
  end

end
