class UsersController < ApplicationController
  def show
    @user = current_user
    @i = 0
    @max = 0
  end

  def matching
    @user = current_user
    @i = 0
    @max = 0
    end

  def roommates
    @user = current_user
    @i = 0
    @max = 0
  end

  def viewuser
      @user = User.find(params[:id])
  end
end