class Result < ActiveRecord::Base

  belongs_to :winner, class: "Hero"
  belongs_to :loser, class: "Hero"

  validates :winner, :loser, :mode,
    presence: true
    
end
