class ApplicationController < ActionController::Base
  before_action :current_user, :create_session
  before_action :set_search_value, if: :not_admin?
  include Pagy::Backend
  around_action :switch_locale, if: :not_admin?


  def index
    redirect_to articles_path
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.locale = params[:locale]
    I18n.with_locale(locale, &action)
  end

  def change_locale
    back = request.referrer || root_path
    back.gsub!(%r{/(ja|en)}, "/#{params[:locale]}")
    redirect_to back
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  # def pagy_get_vars(collection, vars)
  #   vars
  # end
  private

    def create_session
      session[:user_id] ||= cookies[:user_id]
    end
    
    def current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
    def logged_in?
      redirect_to login_path unless @current_user
    end
    
    def set_search_value
      @search_value = [[t('shared.search_partial'), 0], [t('shared.search_front'), 1], [t('shared.search_back'), 2], [t('shared.search_all'), 3]]
    end
    
    def not_admin?
      true
    end
end
