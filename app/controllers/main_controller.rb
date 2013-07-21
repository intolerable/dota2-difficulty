class MainController < ApplicationController

  def home
    check_if_app_disabled!
    @first_hero, @second_hero = *Hero.random(2)
    @mode = ((session[:done] || 0) / 5) % 2 == 0 ? "upper" : "lower"
  end

  def ceiling
    check_if_app_disabled!
    @first_hero, @second_hero = *Hero.random(2)
    @mode = "upper"
    @matchup_mode = "upper"
    render "home"
  end

  def floor
    check_if_app_disabled!
    @first_hero, @second_hero = *Hero.random(2)
    @mode = "lower"
    @matchup_mode = "lower"
    render "home"
  end

  def graph
    @heroes = Hero.all
  end

  def results
    @heroes = Hero.all
    respond_to do |format|
      format.html { authenticate! }
      format.json { render json: @heroes.map(&:to_json) }
      format.csv do
        authenticate!
        require "csv"
        results_csv = CSV.generate do |csv|
          csv << ["Hero name", "Skill ceiling", "Skill ceiling responses", "Skill floor", "Skill floor responses"]
          @heroes.each do |hero|
            csv << [hero.name, hero.upper.rating, hero.upper.games, hero.lower.rating, hero.lower.games]
          end
        end
        render :text => results_csv
      end
    end
  end

  def make
    check_if_app_disabled!
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
