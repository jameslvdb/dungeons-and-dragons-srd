require "application_system_test_case"

class ArmorTest < ApplicationSystemTestCase
  setup do
    @armor = armor(:one)
  end

  test "visiting the index" do
    visit armor_url
    assert_selector "h1", text: "Armor"
  end

  test "creating a Armor" do
    visit armor_url
    click_on "New Armor"

    fill_in "AC", with: @armor.ac
    fill_in "Armor type", with: @armor.armor_type
    fill_in "Description", with: @armor.description
    fill_in "Name", with: @armor.name
    check "Stealth disadvantage" if @armor.stealth_disadvantage
    fill_in "Strength requirement", with: @armor.strength_requirement
    fill_in "Value", with: @armor.value
    fill_in "Weight", with: @armor.weight
    click_on "Create Armor"

    assert_text "Armor was successfully created"
    click_on "Back"
  end

  test "updating a Armor" do
    visit armor_url
    click_on "Edit", match: :first

    fill_in "AC", with: @armor.ac
    fill_in "Armor type", with: @armor.armor_type
    fill_in "Description", with: @armor.description
    fill_in "Name", with: @armor.name
    check "Stealth disadvantage" if @armor.stealth_disadvantage
    fill_in "Strength requirement", with: @armor.strength_requirement
    fill_in "Value", with: @armor.value
    fill_in "Weight", with: @armor.weight
    click_on "Update Armor"

    assert_text "Armor was successfully updated"
    click_on "Back"
  end

  test "destroying a Armor" do
    visit armor_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Armor was successfully destroyed"
  end
end
