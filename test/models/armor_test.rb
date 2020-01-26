require 'test_helper'

class ArmorTest < ActiveSupport::TestCase
  # Specify the fixtures to load
  fixtures :armor

  test "armor attributes must not be empty" do
    armor = Armor.new
    assert armor.invalid?
    assert armor.errors[:name].any?
    assert armor.errors[:description].any?
    assert armor.errors[:ac].any?
    assert armor.errors[:strength_requirement].any?
    assert armor.errors[:stealth_disadvantage].any?
    assert armor.errors[:weight].any?
    assert armor.errors[:value].any?
  end

  test "weight, value, and ac attributes must be non-negative" do
    armor = Armor.new(armor(:one).attributes)
    armor.name = "asdf" # new name to get past uniqueness validation

    integer_attributes = %i[ac value weight]
    integer_attributes.each do |attr|
      armor.send("#{attr}=", -1)
      assert armor.invalid?
      assert_equal ["must be greater than or equal to 0"], armor.errors[attr]
      armor.send("#{attr}=", 0)
      assert armor.valid?
    end
  end

  test "strength requirement must be between 0 and 20" do
    armor = Armor.new(armor(:one).attributes)
    armor.name = "asdf" # new name to get past uniqueness validation

    armor.strength_requirement = -1
    assert armor.invalid?
    assert_equal ["must be between 0 and 20"], armor.errors[:strength_requirement]

    armor.strength_requirement = 21
    assert armor.invalid?
    assert_equal ["must be between 0 and 20"], armor.errors[:strength_requirement]

    armor.strength_requirement = 10
    assert armor.valid?
  end

  test "armor type must be light, medium, or heavy" do
    armor = Armor.new(armor(:one).attributes)
    armor.name = "asdf" # new name to get past uniqueness validation

    armor.armor_type = "invalid type"
    assert armor.invalid?
    assert_equal ["is not included in the list"], armor.errors[:armor_type]

    armor.armor_type = Armor::ARMOR_TYPES.values.sample
    assert armor.valid?
  end
end
