class MainController < ApplicationController

  def home
    @first_hero, @second_hero = *Hero.random(2)
    @mode = ["upper", "lower"].sample
  end

  def ceiling
    @first_hero, @second_hero = *Hero.random(2)
    @mode = "upper"
    render "home"
  end

  def floor
    @first_hero, @second_hero = *Hero.random(2)
    @mode = "lower"
    render "home"
  end

  def results
    @heroes = Hero.all
  end

  def make
    @first_hero = Hero.find params[:winner]
    @second_hero = Hero.find params[:loser]
    @mode = params[:mode]
    matchup_mode = params[:matchup_mode]
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
    if matchup_mode == "upper"
      redirect_to "/ceiling"
    elsif matchup_mode == "lower"
      redirect_to "/floor"
    else
      redirect_to root_path
    end
  end

end
