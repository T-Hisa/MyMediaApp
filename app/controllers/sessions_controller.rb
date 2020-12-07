class SessionsController < ApplicationController
  def create
    
    session[:user_id] = @user.id
  end

  def destroy
  end

end
