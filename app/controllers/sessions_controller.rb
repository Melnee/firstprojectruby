class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            #save the user.id in session if the login was a success
            session[:user_id] = user.id
            flash[:notice] = "Successfully logged in!"
            redirect_to user
        else
            flash.now[:notice] = "Incorrect login"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Successfully logged out"
        redirect_to root_path

    end

end