module ApplicationHelper
    def gravatar_for(user, options = {size: 80})
        email_address = user.email.downcase if user.email
        hash = Digest::MD5.hexdigest(email_address) if user.email
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
    end

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
end
