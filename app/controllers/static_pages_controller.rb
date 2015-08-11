class StaticPagesController < ApplicationController
  before_action :redirect_anonymous_user, only: :home

  def home
  end

  private
  def redirect_anonymous_user
    redirect_to new_session_url unless current_user
  end
end
