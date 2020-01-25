require 'test_helper'

class WeaponsHelperTest < ActionView::TestCase
  test 'should return 1d6 piercing' do
    assert_equal '1d6 piercing', render_damage(weapons(:shortsword))
  end

  test 'should return 1d8 slashing' do
    assert_equal '1d8 slashing', render_damage(weapons(:longsword))
  end
end
