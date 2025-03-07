require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end


  test "should load the edit page correctly" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "must display the title 'Product Edition' on the edit page" do
    get edit_product_url(@product)
    assert_select "h1", "Editing product"
  end
  test "should display the message 'Product not registered' when the product does not exist" do
    get edit_product_path(id: -1)  
  
    assert_redirected_to products_path
    assert_equal "Product not registered", flash[:alert]
  end
  test "You should disable the save button if any field is blank" do
    get edit_product_url(@product)
    assert_select "input[type=submit][disabled]", false 
  end
end