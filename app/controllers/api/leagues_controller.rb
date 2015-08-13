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
      render json: @league, status: :uprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def index
    if params[:user_leagues] && current_user
      @user_leagues = true
      @leagues = current_user.leagues
                    .includes(:teams)
                    .where(teams: { manager_id: current_user.id })
    else
      @leagues = League.all
    end
    render :index
  end

  def show
    @league = League.find(params[:id])
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
