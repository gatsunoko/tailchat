class UsersController < ApplicationController
  def new  
    @user = User.new  
  end  
  def show
    
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to root_url, :notice => "edit up!"
    else
      render "edit"
    end
  end

  def create 
    @user = User.new(user_params)  
    if @user.save  
      redirect_to root_url, :notice => "Signed up!"  
    else  
      render "new" 
    end
  end  

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
