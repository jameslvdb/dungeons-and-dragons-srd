require 'test_helper'

class SpellsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spell = spells(:sacred_flame)
  end

  test "should get index" do
    get spells_url
    assert_response :success
    assert_select 'h1', 'Spells'
    assert_select 'th', 'Name'
    assert_select 'th', 'Level'
    assert_select 'th', 'School'
    assert_select 'th', 'Source'
    assert_select 'td', 'Sacred Flame'
    assert_select 'td', 'cantrip'
    assert_select 'td', 'Evocation'
  end

  test "should get new" do
    get new_spell_url
    assert_response :success
  end

  test "should create spell" do
    assert_difference('Spell.count') do
      post spells_url, params: { spell: { casting_time: @spell.casting_time, classes: @spell.classes, description: @spell.description, duration: @spell.duration, level: @spell.level, material: @spell.material, name: @spell.name, range: @spell.range, ritual: @spell.ritual, school: @spell.school, somatic: @spell.somatic, source: @spell.source, verbal: @spell.verbal } }
    end

    assert_redirected_to spell_url(Spell.last)
  end

  test "should show spell" do
    get spell_url(spells(:sacred_flame))
    assert_response :success
    assert_select 'p em', 'Evocation cantrip'
    assert_select 'p strong', 4

    get spell_url(spells(:magic_missile))
    assert_response :success
    assert_select 'p em', '1st-level evocation'
  end

  test "should get edit" do
    get edit_spell_url(@spell)
    assert_response :success
  end

  test "should update spell" do
    patch spell_url(@spell), params: { spell: { casting_time: @spell.casting_time, classes: @spell.classes, description: @spell.description, duration: @spell.duration, level: @spell.level, material: @spell.material, name: @spell.name, range: @spell.range, ritual: @spell.ritual, school: @spell.school, somatic: @spell.somatic, source: @spell.source, verbal: @spell.verbal } }
    assert_redirected_to spell_url(@spell)
  end

  test "should destroy spell" do
    assert_difference('Spell.count', -1) do
      delete spell_url(@spell)
    end

    assert_redirected_to spells_url
  end
end
