require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get lojas" do
    get :lojas
    assert_response :success
  end

  test "should get loja" do
    get :loja
    assert_response :success
  end

  test "should get perfil" do
    get :perfil
    assert_response :success
  end

end