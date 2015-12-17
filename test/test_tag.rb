require 'minitest/autorun'
require 'evertils/common'

class TagTest < Minitest::Test
  def test_tag_found
    tag = Evertils::Common::Entity::Tag.new

    assert tag.find('done')
  end

  def test_tag_not_found
    tag = Evertils::Common::Entity::Tag.new

    assert_nil tag.find('invalid_tag_name')
  end

  def test_tag_create
    tag = Evertils::Common::Entity::Tag.new

    date = DateTime.now.to_s
    assert tag.create(date).is_a? Evernote::EDAM::Type::Tag
    assert tag.expunge(date)
  end
end