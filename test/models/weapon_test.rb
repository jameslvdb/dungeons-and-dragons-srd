require 'test_helper'

class WeaponTest < ActiveSupport::TestCase
  test "weapon attributes must not be empty" do
    weapon = Weapon.new
    assert weapon.invalid?
    assert weapon.errors[:name].any?
    assert weapon.errors[:weapon_type].any?
    assert weapon.errors[:category].any?
    assert weapon.errors[:value].any?
    assert weapon.errors[:weight].any?
  end

  test "weapon is not valid without a unique name" do
    weapon = Weapon.new(name: weapons(:shortsword).name,
                        weapon_type: 'melee',
                        category: 'simple',
                        value: 1000,
                        weight: 2)
    assert weapon.invalid?
    assert_equal ["has already been taken"], weapon.errors[:name]
  end
end
