class Api::LeaguesController < ApplicationController
  def new
    @league = League.new
    render json: @league
  end

  def create
    @league = current_user.commissioned_leagues.new(league_params)
    @league.score_rule = ScoreRule.new
    @league.roster_rule = RosterRule.new
    if @league.save
      render :show
    else
      render json: @league.errors.full_messages, status: :uprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def index
    if params[:user_leagues] && current_user
      @user_leagues = true
      @leagues = League.users_leagues_and_teams(current_user.id)
      @week = Week.current_week
    else
      @leagues = League.all
    end
    render :index
  end

  def show
    @league = League.includes(:teams, :members, :score_rule).find(params[:id])
    @week = Week.current_week
    @score_rule = @league.score_rule
    @team = current_user.team_in_league(params[:id]) if params[:user_team]
    @as_roster_slots = true if params[:roster_slots]
    @best_record = @league.best_record
    if @league
      render :show
    else
      render json: @league, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
  def league_params
    params.require(:league).permit(
      :name, :public, :redraft, :match_type,
      :num_teams, :num_divisions
    )
  end
end
