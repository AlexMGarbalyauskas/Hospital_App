# app/controllers/application_controller.rb


#sets up global behavior for all 
#controllers in Rails app
class ApplicationController < ActionController::Base
  
  #make user login first
  before_action :require_login


  #runs before every request. It looks at the session[:user_id] 
  #and, if present, finds the corresponding User record. 
  #That user is stored in a thread‑safe Current 
  #object so it can be accessed anywhere in the request cycle
  before_action :set_current_user


  #includes Pundit library for authorization handling 
  include Pundit
 
  #required to login 
  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to access this section."
    end
  end


  #rescue from Pundit global auth error 
  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
