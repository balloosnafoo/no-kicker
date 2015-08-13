class Api::TeamsController < ApplicationController
  def create
    # fail
    @team = current_user.teams.new(team_params)
    if @team && @team.save
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
    @team = Team.find(params[:id])
    render json: @team
  end

  def destroy
  end

  private
  def team_params
    params.require(:team).permit(:name, :league_id, :division)
  end
end
