# app/controllers/users_controller.rb



# sets up a controller to handle user registration/sign-up




# main class
class UsersController < ApplicationController




#1
  # displays sign-up form
  def new
    @user = User.new
  end
#1 end





#2 
  # create new user
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "sign up success"
    else
      render :new, status: :unprocessable_entity
    end
  end
# 2 end





  private
#3
  # strong parameters for user
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
#3 end





end # end of class
