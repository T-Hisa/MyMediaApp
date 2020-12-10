class ApplicationController < ActionController::Base
  before_action :current_user
  # include Pagy::Backendd
  around_action :switch_locale

  def switch_locale(&action)
    # binding.pry
    locale = params[:locale] || I18n.default_locale
    I18n.locale = params[:locale]
    I18n.with_locale(locale, &action)
    # binding.pry
  end

  def change_locale
    back = request.referrer || root_path
    back.gsub!(/\/(ja|en)\//, "/#{params[:locale]}/")
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

  private
    def current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      redirect_to articles_path unless @current_user
    end
end
