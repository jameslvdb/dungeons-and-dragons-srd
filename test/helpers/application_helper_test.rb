require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'should return 10 gp' do
    assert_equal '5 gp', format_value(500)
  end

  test 'should return 10 sp' do
    assert_equal '5 sp', format_value(50)
  end

  test 'should return 10 cp' do
    assert_equal '5 cp', format_value(5)
  end
end
