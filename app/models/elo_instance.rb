class EloInstance < ActiveRecord::Base
  include Elo::Player

  has_one :hero

  before_create :start_elo!

end
