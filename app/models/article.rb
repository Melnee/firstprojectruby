class Article < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true, length: { minimum: 10 }
    belongs_to :user
    #many to many join via join table
    has_many :article_categories
    has_many :categories, through: :article_categories
end
