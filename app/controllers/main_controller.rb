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
    if @first_hero && @second_hero && ["upper", "lower"].include?(@mode)
      if @mode == "upper"
        @first_hero.upper.beats @second_hero.upper
      elsif @mode == "lower"
        @first_hero.lower.beats @second_hero.lower
      end
      Result.create winner: @first_hero, loser: @second_hero, mode: @mode
    else
      puts "Invalid result!!"
    end
    redirect_to root_path
  end

end
