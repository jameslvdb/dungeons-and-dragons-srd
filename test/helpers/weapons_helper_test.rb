require 'test_helper'

class WeaponsHelperTest < ActionView::TestCase
  test 'should return 1d6 piercing' do
    assert_equal '1d6 piercing', render_damage(weapons(:shortsword))
  end

  test 'should return 1d8 slashing (1d10)' do
    assert_equal '1d8 slashing (1d10)', render_damage(weapons(:longsword))
  end
end
