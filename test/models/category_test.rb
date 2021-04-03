require "test_helper"

class CategoryTest < ActiveSupport::TestCase


    def setup
        @category = Category.new(name: "Sports")
    end


  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    #create instance variable
    @category.name = " "
    #check if the category is NOT valid, via assert_not
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save 
    @category2 = Category.new(name: "Sports")
    #validate if category2 is valid. It won't be so this should return true
    assert_not @category2.valid?
  end

  test "name should not be too long" do
    @category.name = "a" *26
    assert_not @category.valid?
  end
  
  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end

end 