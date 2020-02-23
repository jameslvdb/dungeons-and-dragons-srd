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

  test "should render HP as 75 (10d8 + 30)" do
    monster = monsters(:humanoid)
    assert_equal '75 (10d8 + 30)', render_hp(monster)
  end

  test "should render HP as 68 (8d10 + 24)" do
    monster = monsters(:demon)
    assert_equal '68 (8d10 + 24)', render_hp(monster)
  end
end
