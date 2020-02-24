require 'test_helper'

class MagicItemsHelperTest < ActionView::TestCase
  test 'description should be Armor, rare (requires attunement)' do
    item = magic_items(:one)
    assert_equal 'Armor, rare (requires attunement)', render_base_description(item)
  end
end
