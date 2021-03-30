class UsersController < ApplicationController

  # GET /users/new
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome User!"
      redirect_to articles_path 
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user = User.find(params[:id])
      flash[:notice] = "Successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end


  private 
 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
