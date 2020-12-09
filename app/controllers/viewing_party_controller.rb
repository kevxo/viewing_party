class ViewingPartyController < ApplicationController
  def new; end

  def create
    party = current_user.parties.create(party_params)
    if params[:guests]
      params[:guests].values.flatten.each do |id|
        party.guests.create!(guest_id: id.to_i)
      end
    end
    redirect_to '/dashboard'
  end

  private

  def party_params
    params.permit(:movie_title, :duration, :date, :start_time, :movie_id)
  end
end
