class DashboardController < ApplicationController
  before_action :require_user

  def index
    @friends = current_user.friends
    @friends << current_user.inverse_friends
  end
end
