class Api::PlayersController < ApplicationController
  def index
    if params[:league_id]
      @players = Player.with_league_contracts(params[:league_id])
      @league_specific = true
    else
      @players = Player.all
    end
    render :index
  end
end

# Ryan's notes about active record subqueries
# subquery = # some activerecord relation
# Model.select(stuff).from(subquery).joins(other_table)
