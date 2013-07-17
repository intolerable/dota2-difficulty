class MainController < ApplicationController

  def home
    @first_hero, @second_hero = *Hero.random(2)
    @mode = ["upper", "lower"].sample
  end

  def results
    @heroes = Hero.all
  end

  def make
    @first_hero = Hero.find params[:winner]
    @second_hero = Hero.find params[:loser]
    @mode = params[:mode]
    if @mode == "upper"
      @first_hero.upper.beats @second_hero.upper
    else
      @first_hero.lower.beats @second_hero.lower
    end
    redirect_to root_path
  end

end
