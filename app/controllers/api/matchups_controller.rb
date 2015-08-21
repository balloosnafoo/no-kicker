class Api::MatchupsController < ApplicationController
  def index
    @matchups = Week.matchups.includes(:team_1, :team_2).where(matchups: {league_id: params[:league_id]})
    render :index
  end
end
