require 'test_helper'

class WeaponPropertyTest < ActiveSupport::TestCase
  test 'weapon property attributes must not be empty' do
    property = WeaponProperty.new
    assert property.invalid?
    assert property.errors[:name].any?
    assert property.errors[:abbreviation].any?
  end

  test 'weapon property is not valid without a unique name' do
    property = WeaponProperty.new(name: weapon_properties(:finesse).name,
                                  description: 'desc',
                                  abbreviation: 'X')
    assert property.invalid?
    assert_equal ['has already been taken'], property.errors[:name]
  end

  test 'weapon property is not valid without a unique abbreviation' do
    property = WeaponProperty.new(name: 'new property',
                                  description: 'desc',
                                  abbreviation: weapon_properties(:finesse).abbreviation)
    assert property.invalid?
    assert_equal ['has already been taken'], property.errors[:abbreviation]
  end
end
