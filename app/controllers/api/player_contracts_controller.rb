class Api::PlayerContractsController < ApplicationController
  def create
    @player_contract = PlayerContract.new(player_contract_params)
    team = current_user.team_in_league(params[:league_id])
    @player_contract.team_id = team.id
    if @player_contract.save
      render json: @player_contract
    else
      render json: @player_contract.errors.full_messages
    end
  end

  private
  def player_contract_params
    params.require(:player_contract).permit(:player_id)
  end
end
