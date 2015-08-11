class Api::LeagueMembershipsController < ApplicationController
  def create
    @league = current_user.leagues.new(league_membership_params)
    if @league.save
      render json: @league
    else
      render json: @league.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    # This should only work before the draft has taken place.
    # Maybe it won't be implemented at all because it probably won't show
    # in the demo.
  end

  private
  def league_membership_params
    params.require(:league_membership).permit(:league_id)
  end
end
