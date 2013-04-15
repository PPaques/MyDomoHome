# -*- encoding : utf-8 -*-
require 'test_helper'

class SetpointsControllerTest < ActionController::TestCase
  setup do
    @setpoint = setpoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:setpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create setpoint" do
    assert_difference('Setpoint.count') do
      post :create, setpoint: { room_id: @setpoint.room_id, temperature: @setpoint.temperature, times: @setpoint.times }
    end

    assert_redirected_to setpoint_path(assigns(:setpoint))
  end

  test "should show setpoint" do
    get :show, id: @setpoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @setpoint
    assert_response :success
  end

  test "should update setpoint" do
    put :update, id: @setpoint, setpoint: { room_id: @setpoint.room_id, temperature: @setpoint.temperature, times: @setpoint.times }
    assert_redirected_to setpoint_path(assigns(:setpoint))
  end

  test "should destroy setpoint" do
    assert_difference('Setpoint.count', -1) do
      delete :destroy, id: @setpoint
    end

    assert_redirected_to setpoints_path
  end
end
