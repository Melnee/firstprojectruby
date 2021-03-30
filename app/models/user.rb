class User<ApplicationRecord
    #alter object state before save
    #make email downcase before you save the user
    before_save {self.email = email.downcase}

    validates :username, presence: true, 
                length: {minimum: 3, maximum: 25}, 
                uniqueness: {case_sensitive: false}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, 
                length: {maximum: 105}, 
                uniqueness: {case_sensitive: false},
                format: {with: VALID_EMAIL_REGEX}

    #dependent: destroy means that if a user is deleted, all associated articles will be destroyed as well
    has_many :articles, dependent: :destroy
    has_secure_password
end
