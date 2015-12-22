require 'minitest/autorun'
require 'evertils/common'

class TagTest < Minitest::Test

  def setup
    @tag = Evertils::Common::Entity::Tag.new
  end

  def test_tag_found
    assert @tag.find('done')
  end

  def test_tag_not_found
    assert_nil @tag.find('invalid_tag_name')
  end

  def test_tag_create
    date = DateTime.now.to_s
    assert @tag.create(date).is_a? Evernote::EDAM::Type::Tag
    assert @tag.expunge(date)
  end

end