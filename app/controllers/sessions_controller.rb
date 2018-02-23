class SessionsController < ApplicationController
  def create
    sign_in_user User.first
    redirect_to root_path
  end

  def destroy
    sign_out_user
    redirect_to root_path
  end
end
