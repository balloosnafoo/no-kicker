class Api::LeaguesController < ApplicationController
  def new
    @league = League.new
    render json: @league
  end

  def create
    @league = current_user.commissioned_leagues.new(league_params)
    @league.rule_set = RuleSet.new
    if @league.save
      LeagueMembership.create({
        member_id: current_user.id,
        league_id: @league.id
      })
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
      # Update when league_memberships exist!
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
