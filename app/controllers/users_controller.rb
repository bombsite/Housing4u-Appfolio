class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def matching
    @user = current_user
  end
end