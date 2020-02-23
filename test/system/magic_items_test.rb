require "application_system_test_case"

class MagicItemsTest < ApplicationSystemTestCase
  setup do
    @magic_item = magic_items(:one)
  end

  test "visiting the index" do
    visit magic_items_url
    assert_selector "h1", text: "Magic Items"
  end

  test "creating a Magic item" do
    visit magic_items_url
    click_on "New Magic Item"

    fill_in "Attunement", with: @magic_item.attunement
    fill_in "Description", with: @magic_item.description
    fill_in "Name", with: @magic_item.name
    fill_in "Rarity", with: @magic_item.rarity
    fill_in "Tier", with: @magic_item.tier
    fill_in "Weight", with: @magic_item.weight
    check "Wondrous" if @magic_item.wondrous
    click_on "Create Magic item"

    assert_text "Magic item was successfully created"
    click_on "Back"
  end

  test "updating a Magic item" do
    visit magic_items_url
    click_on "Edit", match: :first

    fill_in "Attunement", with: @magic_item.attunement
    fill_in "Description", with: @magic_item.description
    fill_in "Name", with: @magic_item.name
    fill_in "Rarity", with: @magic_item.rarity
    fill_in "Tier", with: @magic_item.tier
    fill_in "Weight", with: @magic_item.weight
    check "Wondrous" if @magic_item.wondrous
    click_on "Update Magic item"

    assert_text "Magic item was successfully updated"
    click_on "Back"
  end

  test "destroying a Magic item" do
    visit magic_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Magic item was successfully destroyed"
  end
end
