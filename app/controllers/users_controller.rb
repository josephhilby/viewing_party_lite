# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[discover show]
  skip_before_action :current_user, only: [:new, :create, :login, :login_form]

  def discover; end

  def new; end

  def show
    @view_parties = @user.view_parties.order('datetime')
  end

  def create
    new_user = User.new(user_params)

    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.email}"
      redirect_to user_path(new_user)
    else
      redirect_to register_path
      flash[:alert] = new_user.errors.full_messages.to_sentence
    end
  end

  def login_form; end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.admin?
        flash[:success] = "Welcome, Administrator #{user.email}"
      elsif user.default?
        session[:user_id] = user.id
        flash[:success] = "Welcome, #{user.email}"
        redirect_to user_path(user)
      end
    else
      flash[:error] = "Unknown username or password"
      render :login_form
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
