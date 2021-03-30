module ApplicationHelper
#all methods made in application_helper are available for use in views, but not necessarily controllers
#put methods in application_controller in order to make them available to all controllers

    def gravatar_for(user, options = {size: 80})
        email_address = user.email.downcase if user.email
        hash = Digest::MD5.hexdigest(email_address) if user.email
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
    end

end
