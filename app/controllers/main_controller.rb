class MainController < ApplicationController

  def home
    @first_hero, @second_hero = *Hero.random(2)
    @mode = ((session[:done] || 0) / 5) % 2 == 0 ? "upper" : "lower"
  end

  def ceiling
    @first_hero, @second_hero = *Hero.random(2)
    @mode = "upper"
    @matchup_mode = "upper"
    render "home"
  end

  def floor
    @first_hero, @second_hero = *Hero.random(2)
    @mode = "lower"
    @matchup_mode = "lower"
    render "home"
  end

  def results
    redirect_to root_path unless authenticate
    @heroes = Hero.all
  end

  def make
    @first_hero = Hero.find params[:winner]
    @second_hero = Hero.find params[:loser]
    @mode = params[:mode]
    @matchup_mode = params[:matchup_mode]
    if @first_hero && @second_hero && ["upper", "lower"].include?(@mode)
      if @mode == "upper"
        @first_hero.upper.beats @second_hero.upper
      elsif @mode == "lower"
        @first_hero.lower.beats @second_hero.lower
      end
      if session[:done] == nil
        session[:done] = 1
      else
        session[:done] += 1
      end
      Result.create winner: @first_hero, loser: @second_hero, mode: @mode
    else
      puts "Invalid result!!"
    end
    if @matchup_mode == "upper"
      redirect_to "/ceiling"
    elsif @matchup_mode == "lower"
      redirect_to "/floor"
    else
      redirect_to root_path
    end
  end

end
