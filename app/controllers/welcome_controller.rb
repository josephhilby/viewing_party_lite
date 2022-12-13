# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :current_user, only: [:index]

  def index
    @users = User.all
  end
end
