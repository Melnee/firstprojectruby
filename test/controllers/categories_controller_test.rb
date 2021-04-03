require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #instead of .new method, use the .create method
    #this way it will actually hit the table
    #make sure you create this instance variable, otherwise your methods (like show) won't be able to access it
    @category = Category.create(name: "Sports")
    #in order to run admin check test, simulate a created user that's logged in as admin
    #set admin column to tru to make user. 
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
  end

  test "should get index" do
    #going to categories listing path
    get categories_url
    #asserting that you can get the success response
    assert_response :success
  end

  test "should get new" do
    #call the test_helper.rb file for authentication before doing this method
    sign_in_as(@admin_user)
    #going to new category route, and asserting success
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    #call the test_helper.rb file for authentication before doing this method
      #you have to do it again for each method, even though you already signed in for the new method
      #this is because the data is scrubbed each time during test methods
    sign_in_as(@admin_user)
    #this line is looking for a change in the number of categories once a new category is created
    #so we provide that 1 here, because we want the number to be different by 1
    assert_difference('Category.count', 1) do
      #sending to categories path via post, and the params require a category object with name attribute
      post categories_url, params: { category: { name: "Travel" } }
    end
    #now the latest category created is being sent to that show page
    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not admin" do
    #this line is making sure that no change in categories happens if user is not admin
    assert_no_difference('Category.count') do
      #sending to categories path via post, and the params require a category object with name attribute
      post categories_url, params: { category: { name: "Travel" } }
    end
    #after refusal of creation, because not admin, assert that the redirect goes to the categories index
    assert_redirected_to categories_url
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end

#the rails test command will run the controllers test
#rails system test will run your system tests