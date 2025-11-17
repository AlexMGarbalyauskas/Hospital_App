# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_current_user
  before_action :require_login

  private

  # Require login for all routes except defined public ones
  def require_login
    return if public_route?

    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to access this section."
    end
  end

  # Public routes identified by controller + action, not path helpers
  def public_route?
    # Adjust this list to match your app
    public_routes = [
      { controller: "sessions", action: "new" },     # login page
      { controller: "sessions", action: "create" },  # login submit
      { controller: "users", action: "new" },        # signup page (if exists)
      { controller: "users", action: "create" },     # signup submit
      { controller: "home", action: "index" }        # allow homepage without login
    ]

    public_routes.any? do |route|
      route[:controller] == params[:controller] &&
      route[:action] == params[:action]
    end
  end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
