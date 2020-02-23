require "application_system_test_case"

class MonstersTest < ApplicationSystemTestCase
  setup do
    @monster = monsters(:one)
  end

  test "visiting the index" do
    visit monsters_url
    assert_selector "h1", text: "Monsters"
  end

  test "creating a Monster" do
    visit monsters_url
    click_on "New Monster"

    fill_in "AC", with: @monster.ac
    fill_in "Actions", with: @monster.actions
    fill_in "Challenge", with: @monster.challenge
    fill_in "Charisma", with: @monster.charisma
    fill_in "Condition immunities", with: @monster.condition_immunities
    fill_in "Constitution", with: @monster.constitution
    fill_in "Damage immunities", with: @monster.damage_immunities
    fill_in "Damage resistances", with: @monster.damage_resistances
    fill_in "Dexterity", with: @monster.dexterity
    fill_in "HP", with: @monster.hp
    fill_in "HP formula", with: @monster.hp_formula
    fill_in "Intelligence", with: @monster.intelligence
    fill_in "Languages", with: @monster.languages
    fill_in "Legendary actions", with: @monster.legendary_actions
    fill_in "Monster type", with: @monster.monster_type
    fill_in "Name", with: @monster.name
    fill_in "Saving throws", with: @monster.saving_throws
    fill_in "Senses", with: @monster.senses
    fill_in "Size", with: @monster.size
    fill_in "Skills", with: @monster.skills
    fill_in "Speed", with: @monster.speed
    fill_in "Strength", with: @monster.strength
    fill_in "Traits", with: @monster.traits
    fill_in "Wisdom", with: @monster.wisdom
    click_on "Create Monster"

    assert_text "Monster was successfully created"
    click_on "Back"
  end

  test "updating a Monster" do
    visit monsters_url
    click_on "Edit", match: :first

    fill_in "AC", with: @monster.ac
    fill_in "Actions", with: @monster.actions
    fill_in "Challenge", with: @monster.challenge
    fill_in "Charisma", with: @monster.charisma
    fill_in "Condition immunities", with: @monster.condition_immunities
    fill_in "Constitution", with: @monster.constitution
    fill_in "Damage immunities", with: @monster.damage_immunities
    fill_in "Damage resistances", with: @monster.damage_resistances
    fill_in "Dexterity", with: @monster.dexterity
    fill_in "HP", with: @monster.hp
    fill_in "HP formula", with: @monster.hp_formula
    fill_in "Intelligence", with: @monster.intelligence
    fill_in "Languages", with: @monster.languages
    fill_in "Legendary actions", with: @monster.legendary_actions
    fill_in "Monster type", with: @monster.monster_type
    fill_in "Name", with: @monster.name
    fill_in "Saving throws", with: @monster.saving_throws
    fill_in "Senses", with: @monster.senses
    fill_in "Size", with: @monster.size
    fill_in "Skills", with: @monster.skills
    fill_in "Speed", with: @monster.speed
    fill_in "Strength", with: @monster.strength
    fill_in "Traits", with: @monster.traits
    fill_in "Wisdom", with: @monster.wisdom
    click_on "Update Monster"

    assert_text "Monster was successfully updated"
    click_on "Back"
  end

  test "destroying a Monster" do
    visit monsters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monster was successfully destroyed"
  end
end
