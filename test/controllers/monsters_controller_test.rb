require 'test_helper'

class MonstersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monster = monsters(:humanoid)
  end

  test 'should get index' do
    get monsters_url
    assert_response :success
  end

  test 'should get new' do
    get new_monster_url
    assert_response :success
  end

  test 'should create monster' do
    assert_difference('Monster.count') do
      post monsters_url, params: {
        monster: {
          ac: @monster.ac, actions: @monster.actions, alignment: @monster.alignment,
          challenge: @monster.challenge, charisma: @monster.charisma,
          condition_immunities: @monster.condition_immunities,
          constitution: @monster.constitution, damage_immunities: @monster.damage_immunities,
          damage_resistances: @monster.damage_resistances, dexterity: @monster.dexterity,
          hp: @monster.hp, hp_formula: @monster.hp_formula, intelligence: @monster.intelligence,
          languages: @monster.languages, legendary_actions: @monster.legendary_actions,
          monster_type: @monster.monster_type, name: @monster.name,
          saving_throws: @monster.saving_throws, senses: @monster.senses, size: @monster.size,
          skills: @monster.skills, speed: @monster.speed, strength: @monster.strength,
          traits: @monster.traits, wisdom: @monster.wisdom
        }
      }
    end

    assert_redirected_to monster_url(Monster.last)
  end

  test 'should show monster' do
    get monster_url(@monster)
    assert_response :success
  end

  test 'should get edit' do
    get edit_monster_url(@monster)
    assert_response :success
  end

  test 'should update monster' do
    patch monster_url(@monster), params: {
      monster: {
        ac: @monster.ac, actions: @monster.actions, alignment: @monster.alignment,
        challenge: @monster.challenge, charisma: @monster.charisma,
        condition_immunities: @monster.condition_immunities,
        constitution: @monster.constitution, damage_immunities: @monster.damage_immunities,
        damage_resistances: @monster.damage_resistances, dexterity: @monster.dexterity,
        hp: @monster.hp, hp_formula: @monster.hp_formula, intelligence: @monster.intelligence,
        languages: @monster.languages, legendary_actions: @monster.legendary_actions,
        monster_type: @monster.monster_type, name: @monster.name,
        saving_throws: @monster.saving_throws, senses: @monster.senses, size: @monster.size,
        skills: @monster.skills, speed: @monster.speed, strength: @monster.strength,
        traits: @monster.traits, wisdom: @monster.wisdom
      }
    }
    assert_redirected_to monster_url(@monster)
  end

  test 'should destroy monster' do
    assert_difference('Monster.count', -1) do
      delete monster_url(@monster)
    end

    assert_redirected_to monsters_url
  end
end
