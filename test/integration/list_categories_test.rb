require "test_helper"
#goals: make two categories, ensure they show up in the index, and ensure they're links to their respective show pages

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    #create the two categories
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test "should show categories listing" do
    get '/categories'
    #now test for the show page paths
    #select an anchor tag link in the categories index, that goes to the show page for @category 
    #and make it so that the text that shows up is the category name
    assert_select "a[href=?]", category_path(@category), text: @category.name
    #select an anchor tag link in the categories index, that goes to the show page for @category2
    #and make it so that the text that shows up is the category name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
