require 'test_helper'

class WeaponsHelperTest < ActionView::TestCase
  test 'should return 1d6 piercing' do
    assert_equal '1d6 piercing', render_damage(weapons(:shortsword))
  end

  test 'should return 1d8 slashing' do
    assert_equal '1d8 slashing', render_damage(weapons(:longsword))
  end

  test 'should return Ammunition (range 80/320)' do
    assert_equal 'Ammunition (range 80/320)', render_properties(weapons(:shortbow))
  end

  test 'should return Versatile (1d10)' do
    assert_equal 'Versatile (1d10)', render_properties(weapons(:longsword))
  end
end
