class ArticleCategory < ApplicationRecord
    #join table between many to many articles and categories
    belongs_to :article
    belongs_to :category
end