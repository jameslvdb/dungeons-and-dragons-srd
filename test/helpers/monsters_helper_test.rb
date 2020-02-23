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
end
