class Api::PlayerContractsController < ApplicationController
  def create
    @player_contract = PlayerContract.new(player_contract_params)
    team = current_user.team_in_league(params[:league_id])
    @player_contract.team_id = team.id
    if @player_contract.save
      render json: @player_contract
    else
      render json: @player_contract.errors.full_messages,
                   status: :unprocessable_entity
    end
  end

  def destroy
    @player_contract = PlayerContract.find(params[:id])
    @player_contract.destroy()
    render json: @player_contract
  end

  private
  def player_contract_params
    params.require(:player_contract).permit(:player_id)
  end
end
