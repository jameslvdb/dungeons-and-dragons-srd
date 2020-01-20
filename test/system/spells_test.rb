require "application_system_test_case"

class SpellsTest < ApplicationSystemTestCase
  setup do
    @spell = spells(:one)
  end

  test "visiting the index" do
    visit spells_url
    assert_selector "h1", text: "Spells"
  end

  test "creating a Spell" do
    visit spells_url
    click_on "New Spell"

    fill_in "Casting time", with: @spell.casting_time
    fill_in "Classes", with: @spell.classes
    fill_in "Description", with: @spell.description
    fill_in "Duration", with: @spell.duration
    fill_in "Level", with: @spell.level
    fill_in "Material", with: @spell.material
    fill_in "Name", with: @spell.name
    fill_in "Range", with: @spell.range
    check "Ritual" if @spell.ritual
    fill_in "School", with: @spell.school
    check "Somatic" if @spell.somatic
    fill_in "Source", with: @spell.source
    check "Verbal" if @spell.verbal
    click_on "Create Spell"

    assert_text "Spell was successfully created"
    click_on "Back"
  end

  test "updating a Spell" do
    visit spells_url
    click_on "Edit", match: :first

    fill_in "Casting time", with: @spell.casting_time
    fill_in "Classes", with: @spell.classes
    fill_in "Description", with: @spell.description
    fill_in "Duration", with: @spell.duration
    fill_in "Level", with: @spell.level
    fill_in "Material", with: @spell.material
    fill_in "Name", with: @spell.name
    fill_in "Range", with: @spell.range
    check "Ritual" if @spell.ritual
    fill_in "School", with: @spell.school
    check "Somatic" if @spell.somatic
    fill_in "Source", with: @spell.source
    check "Verbal" if @spell.verbal
    click_on "Update Spell"

    assert_text "Spell was successfully updated"
    click_on "Back"
  end

  test "destroying a Spell" do
    visit spells_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Spell was successfully destroyed"
  end
end
