class Api::TeamsController < ApplicationController
  def create
    @team = current_user.teams.new(team_params)
    if @team && @team.save
      @team.league.generate_roster_slots(@team)
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
    @team = Team.includes(:players).find(params[:id])
    @roster_slots = true #if params[:roster_slots]
    render :show
  end

  def destroy
  end

  private
  def team_params
    params.require(:team).permit(:name, :league_id, :division)
  end
end
