class Result < ActiveRecord::Base

  belongs_to :winner, class_name: "Hero"
  belongs_to :loser, class_name: "Hero"

  validates :winner, :loser, :mode,
    presence: true

end
