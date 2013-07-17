# `include` this in a class which has the following fields:
#   games [int]
#   rating [int]
#   pro [boolean]
# and do `(instance).start_elo!`

module Elo

  module Player
  
    def starter?
      games < Elo.config[:starter_boundary]
    end
    
    def pro?
      self.pro || ( self.rating > Elo.config[:pro_boundary] )
    end
    
    def beats( player )
      validate! player
      change! player, :win
    end
    
    def loses_to( player )
      validate! player
      change! player, :lose
    end
    
    def draws_to( player )
      validate! player
      change! player, :draw
    end
    
    def k_factor
      (if self.starter?
        Elo.config[:starter_k_factor]
      elsif self.pro?
        Elo.config[:pro_k_factor]
      else
        Elo.config[:k_factor]
      end).to_f
    end
    
    def expected( player )
      player_one = self
      player_two = player
      1.0 / ( 1.0 + 10.0 ** ( ( player_two.rating - player_one.rating ).to_f / 400 ) )
    end

    def start_elo!
      self.pro = false
      self.rating = Elo.config[:default_rating]
      self.games = 0
    end

    protected

    def save_if_active_record!
      if self.class.ancestors.include? ActiveRecord::Base
        self.save!
      end
    end
    
    private
    
    def validate!( player )
      unless player.class.included_modules.include? Elo::Player
        raise TypeError.new "#{player.inspect} isn't a Player"
      end
      true
    end
    
    def change!( player, result_symbol )
      result = { :win => 1.0, :draw => 0.5, :lose => 0.0 }[result_symbol]
      self_rating_change = self.k_factor * ( result - self.expected(player) )
      player_rating_change = player.k_factor * ( ( 1.0 - result ) - player.expected(self) )
      self.rating += self_rating_change.to_i
      self.games += 1
      self.pro = self.pro?
      player.rating += player_rating_change.to_i
      player.games += 1
      player.pro = player.pro?
      self.save_if_active_record!
      player.save_if_active_record!
      self
    end
    
  end
  
end
