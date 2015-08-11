class Api::LeaguesController < ApplicationController
  def new
    @league = League.new
    render json: @league
  end

  def create
    @league = League.new(league_params)
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
      # Update when league_memberships exist!
      @leagues = current_user.commissioned_leagues
    else
      @leagues = League.all
    end
    render json: @leagues
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
