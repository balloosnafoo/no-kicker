class Api::RosterSlotsController < ApplicationController
  def update
    @roster_slot = RosterSlot.find(params[:id])
    if @roster_slot.update(roster_slot_params)
      render json: @roster_slot
    else
      render json: @roster_slot.errors.full_messages,
                   status: :unprocessable_entity
    end
  end

  private
  def roster_slot_params
    params.require(:roster_slot).permit(:player_id, :order)
  end
end
