require 'test_helper'

class ConditionTest < ActiveSupport::TestCase
  test "condition attributes must not be empty" do
    condition = Condition.new
    assert condition.invalid?
    assert condition.errors[:name].any?
    assert condition.errors[:description].any?
  end

  test "condition is not valid without a unique name" do
    condition = Condition.new(name: conditions(:deafened).name,
                          description: "desc",)
    assert condition.invalid?
    assert_equal ["has already been taken"], condition.errors[:name]
  end
end
