require 'test_helper'

class ArmorControllerTest < ActionDispatch::IntegrationTest
  setup do
    @armor = armor(:one)
  end

  test 'should get index' do
    get armor_index_url
    assert_response :success
    assert_select 'h1', 'Armor'

    column_headers = ['Name', 'Cost', 'Armor Class (AC)', 'Strength', 'Stealth', 'Weight']
    column_headers.each do |header|
      assert_select 'th', header
    end
    assert_select 'th', column_headers.length
  end

  test 'should get new' do
    get new_armor_url
    assert_response :success
  end

  test 'should create armor' do
    assert_difference('Armor.count') do
      post armor_index_url, params: { armor: { ac: @armor.ac, armor_type: @armor.armor_type, description: @armor.description, name: "new armor", stealth_disadvantage: @armor.stealth_disadvantage, strength_requirement: @armor.strength_requirement, value: @armor.value, weight: @armor.weight } }
    end

    assert_redirected_to armor_url(Armor.last)
  end

  test 'should show armor' do
    get armor_url(@armor)
    assert_response :success
  end

  test 'should get edit' do
    get edit_armor_url(@armor)
    assert_response :success
  end

  test 'should update armor' do
    patch armor_url(@armor), params: { armor: { ac: @armor.ac, armor_type: @armor.armor_type, description: @armor.description, name: "some new name", stealth_disadvantage: @armor.stealth_disadvantage, strength_requirement: @armor.strength_requirement, value: @armor.value, weight: @armor.weight } }
    assert_redirected_to armor_url(@armor)
  end

  test 'should destroy armor' do
    assert_difference('Armor.count', -1) do
      delete armor_url(@armor)
    end

    assert_redirected_to armor_index_url
  end
end
