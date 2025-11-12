#app/controllers/sessions_controller.rb



# sets up a controller to manage user sessions (login/logout)

# main class
class SessionsController < ApplicationController
    




#1
    # displays login form
    def new 
    end
#1 end 





#2 
    # handles login
    def create 

        # finds user by email
        user = User.find_by(email: params[:email]) 
        # authenticates user password
        if user.present? && user.authenticate(params[:password])
        # stores user id in session to keep user logged in
        session[:user_id] = user.id 
        # redirects to home page with success notice
        redirect_to root_path, notice: "logged in successfully" 


        # handles invalid login
        else 
            flash[:alert] = "invalid email or password" 
            render :new  
        end
        
    end
#2 end 
    



#3 
    # handles logout
    def destroy 
        session[:user_id] = nil
        redirect_to root_path, notice: "logged out" 
    end
#3 end





end # end of class
