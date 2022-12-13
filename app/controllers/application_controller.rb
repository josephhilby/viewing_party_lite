# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user
      flash[:error] = "You must be logged in to view this content"
      redirect_to root_path
    end
  end
end
