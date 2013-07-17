$LOAD_PATH << File.dirname(__FILE__)
require 'elo/player'

module Elo
  
  def self.version
    "0.1.0"
  end

  @@config = {
    :default_rating => 1000,
    :pro_boundary => 2400,
    :starter_boundary => 30,
    :k_factor => 15,
    :pro_k_factor => 10,
    :starter_k_factor => 30 }

  def self.config
    @@config
  end
  
  def self.config=(config)
    @@config = @@config.merge config
  end
  
end
