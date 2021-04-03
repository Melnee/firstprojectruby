class CreateArticleCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :article_categories do |t|
      #you're creating a join table
      #first make a column for the article_id
      t.integer :article_id
      #then make a column for the category_id
      t.integer :category_id
      t.timestamps
    end
  end
end
