class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_current_user
  before_action :require_login

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Require login for all routes except public ones
  def require_login
    return if public_route?

    unless session[:user_id]
      redirect_to sign_in_path, alert: "You must be logged in to access this section."
    end
  end

  # Define public routes that do not require login
  def public_route?
    public_routes = [
      { controller: "sessions", action: "new" },     # login page
      { controller: "sessions", action: "create" },  # login submit
      { controller: "users", action: "new" },        # signup page
      { controller: "users", action: "create" },     # signup submit
      { controller: "home", action: "index" }        # homepage
    ]

    public_routes.any? do |route|
      route[:controller] == params[:controller] &&
      route[:action] == params[:action]
    end
  end
end
