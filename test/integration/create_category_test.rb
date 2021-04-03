require "test_helper"

#Integration test: check how multiple methods interact with EACH OTHER
#as opposed to functional tests which only check each individual function within a controller
class CreateCategoryTest < ActionDispatch::IntegrationTest
  #same method copied over from categories_controller_test.rb
  #admin creation to sign in before methods
  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
    #all methods in this file require an admin sign in, so you can just sign_in in the setup file here:
    sign_in_as(@admin_user)
  end

  test "get new category form and create category" do
    #in the new categories route (the form display)
    get "/categories/new"
    #assert the success at displaying this page,
    assert_response :success
    #and then also assert the success at increasing the category count by 1
    assert_difference 'Category.count', 1 do
      #then go to the post create category path and attempt to create a category with the name "Sports"
      post categories_path, params: {category: {name: "Sports"}}
      #then make sure that there's a redirect, assert the response of the redirect
      assert_response :redirect
    end
  #then follow where the redirect goes, with a bang "!"
  follow_redirect!
  #make sure that the redirect is successsful and the response is showing success
  assert_response :success
  #and make sure that in the response there is a sports creation
  #look for the name in the body of the html page
  assert_match "Sports", response.body
  end

  test "get new category form and reject invalid category submission" do
    #same as before, get the new categories route (the form display)
    get "/categories/new"
    #assert the success at displaying this page,
    assert_response :success
    #BUT THIS TIME, assert that there was no difference in the category count as a response to rejecting an invalid category successfuly
    assert_no_difference 'Category.count', 1 do
      #then go to the post create category path and attempt to create a category with an EMPTY name, to force fail
      post categories_path, params: {category: {name: ""}}
      #no need for a redirect, or to assert success, because you're trying to make sure it fails the invalid submissions 
    end
    #look for the word error and the bootstrap classes for alert in your response
    #if these appear in the response body html, that means the error partial is showing
    #and that means that you've successfully refused to create an invalid category
  assert_match "Error", response.body
  assert_select 'div.alert'
  assert_select 'h2.alert-heading'
  end
end