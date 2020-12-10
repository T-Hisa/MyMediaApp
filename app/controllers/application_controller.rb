class ApplicationController < ActionController::Base
  before_action :current_user
  # include Pagy::Backend

  private
    def current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      redirect_to articles_path unless @current_user
    end
end
