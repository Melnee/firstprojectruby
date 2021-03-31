class UsersController < ApplicationController
  #when userscontroller gets activated, before doing any action, call the private set_user method
  #but only for the show edit destroy and update methods
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #call the require user method from application controller before the edit and update to prevent users from editing other peoples profiles
  before_action :require_user, only: [:edit, :update]

  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome User!"
      redirect_to articles_path 
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def destroy
    #if the user is the current user, aka not admin,
    #make sure to log user out of session or else your application will throw an error
    if @user == current_user
      session[:user_id] = nil
    end
    @user.destroy
    flash[:notice] = "Account and all associatd articles successfully deleted"
    redirect_to articles_path
  end


  private 
 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account."
      redirect_to @user
    end
  end
    

end
