class ApplicationController < ActionController::Base
#all methods here are available to all controllers because they inherit from it

    #the following line makes current_user and logged_in? methods available to views as well, not just to controllers
    #almost as though it were in the application_helper file
    helper_method :current_user, :logged_in?
    def current_user
        #find the user based on the user_id stored in session object, if session has a user_id
        #or syntax below checks if the current_user variable already exists, otherwise do the database query, as described above
        @current_user || User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        #bang bang turns whatever comes after into a boolean
        #so this line means "check if current_user exists"
        !!current_user
    end

    #create a method to block not logged in users from doing certain things
    def require_user
        #if not logged in 
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            #then redirect them away
            redirect_to login_path
        end
    end

end
