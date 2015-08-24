class Api::MatchupsController < ApplicationController
  def index
    week = params[:week] || Week.current_week + 1
    @matchups = Matchup.includes(:team_1, :team_2)
                  .where(
                    week: week, league_id: params[:league_id]
                  )
    render :index
  end
end

# Week.matchups.includes(:team_1, :team_2).where(matchups: { league_id: 1, week: 1 })
