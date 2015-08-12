class Api::TeamsController < ApplicationController
  def create
    @team = current_user.teams.new(team_params)
    if @team && @team.save
      render json: @team
    else
      render json: @team.errors.full_messages
    end
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
  end

  def destroy
  end

  private
  def team_params
    params.require(:team).permit(:name, :league_id)
  end
end
