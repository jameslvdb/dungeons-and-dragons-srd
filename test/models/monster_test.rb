require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  fixtures :monsters

  test 'ability score hash should return the correct values' do
    monster = monsters(:humanoid)
    scores = monster.ability_scores
    assert_equal scores[:str], 1
    assert_equal scores[:dex], 2
    assert_equal scores[:con], 3
    assert_equal scores[:int], 4
    assert_equal scores[:wis], 5
    assert_equal scores[:cha], 6
  end


end
