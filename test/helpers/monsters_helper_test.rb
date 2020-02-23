require 'test_helper'

class MonstersHelperTest < ActionView::TestCase
  test "should return 'medium humanoid, lawful good'" do
    monster = monsters(:humanoid)
    assert_equal 'medium humanoid, lawful good', render_size_type_alignment(monster)
  end

  test "should return 'large demon, chaotic evil'" do
    monster = monsters(:demon)
    assert_equal 'large demon, chaotic evil', render_size_type_alignment(monster)
  end

  test 'should render HP as 75 (10d8 + 30)' do
    monster = monsters(:humanoid)
    assert_equal '75 (10d8 + 30)', render_hp(monster)
  end

  test 'should render HP as 68 (8d10 + 24)' do
    monster = monsters(:demon)
    assert_equal '68 (8d10 + 24)', render_hp(monster)
  end

  ability_scores = (1..20).to_a
  ability_modifiers = ['-5', '-4', '-4', '-3', '-3', '-2', '-2', '-1', '-1', '+0', '+0', '+1', '+1', '+2', '+2', '+3', '+3', '+4', '+4', '+5']

  ability_scores.each_with_index do |score, i|
    test "should render #{score} as #{score} (#{ability_modifiers[i]})" do
      assert_equal "#{score} (#{ability_modifiers[i]})", ability(score)
    end
  end
end
