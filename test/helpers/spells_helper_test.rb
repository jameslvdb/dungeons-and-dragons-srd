require 'test_helper'

class SpellsHelperTest < ActionView::TestCase
  test 'should return cantrip' do
    spell = spells(:sacred_flame)
    assert_equal 'cantrip', ordinalize_level(spell.level)
  end

  test 'should return 1st' do
    spell = spells(:magic_missile)
    assert_equal '1st', ordinalize_level(spell.level)
  end

  test 'should return Evocation cantrip' do
    spell = spells(:sacred_flame)
    assert_equal 'Evocation cantrip', show_spell_level(spell)
  end

  test 'should return 1st-level evocation' do
    spell = spells(:magic_missile)
    assert_equal '1st-level evocation', show_spell_level(spell)
  end
end
