require 'test_helper'

class SpellTest < ActiveSupport::TestCase
  # Specify the fixtures to load
  fixtures :spells

  test 'spell attributes must not be empty' do
    spell = Spell.new
    assert spell.invalid?
    assert spell.errors[:name].any?
    assert spell.errors[:description].any?
    assert spell.errors[:level].any?
    assert spell.errors[:school].any?
    assert spell.errors[:casting_time].any?
    assert spell.errors[:range].any?
    assert spell.errors[:duration].any?
  end

  test 'spell level must be between 0 and 9' do
    spell = Spell.new(name: 'Spell name',
                          description: 'desc',
                          school: 'Evocation',
                          casting_time: '1 action',
                          range: '60 feet',
                          duration: '1 minute'
                        )
    spell.level = -1
    assert spell.invalid?
    assert_equal ['must be between 0 and 9'], spell.errors[:level]

    spell.level = 10
    assert spell.invalid?
    assert_equal ['must be between 0 and 9'], spell.errors[:level]

    spell.level = 1
    assert spell.valid?
  end

  def new_spell(school)
    Spell.new(name: 'Spell name', description: 'desc', level: 1, school: school,
              casting_time: '1 action', range: '60 feet', duration: '1 minute')
  end

  test 'spell school' do
    # D&D schools of magic
    ok = %w[Abjuration Conjuration Divination Enchantment Evocation Illusion Necromancy Transmutation]
    # Skyrim-only schools of magic
    bad = %w[Destruction Alteration Restoration]

    ok.each do |school|
      # the trailing string is written along with the error message if the assertion fails
      assert new_spell(school).valid?, "#{school} shouldn't be invalid"
    end

    bad.each do |school|
      assert new_spell(school).invalid? "#{school} shouldn't be valid"
    end
  end

  test 'spell is not valid without a unique name' do
    spell = Spell.new(name: spells(:magic_missile).name,
                          description: 'desc',
                          level: 1,
                          school: 'Evocation',
                          casting_time: '1 action',
                          range: '60 feet',
                          duration: '1 minute')
    assert spell.invalid?
    assert_equal ['has already been taken'], spell.errors[:name]
  end
end
