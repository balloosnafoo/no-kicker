class Api::TeamsController < ApplicationController
  def create
    @team = current_user.teams.new(team_params)
    if @team && @team.save
      @team.league.generate_roster_slots(@team)
      if @team.league.teams.count == @team.league.num_teams
        @team.league.generate_matchups
      end
      render json: @team
    else
      render json: @team.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
    @team = Team
      .includes(:players, :roster_slots, :player_contracts, :weekly_stats, :roster_rule, :manager)
      .find(params[:id])
    @next_matchup = @team.next_matchup
    @roster_slots = @team.roster_slots
    @score_rule = @team.score_rule
    @week = Week.current_week
    render :show
  end

  def destroy
  end

  private
  def team_params
    params.require(:team).permit(:name, :league_id, :division)
  end
end
