require 'minitest/autorun'
require 'evertils/common'

class TagTest < Minitest::Test

  def setup
    @tag = Evertils::Common::Entity::Tag.new
  end

  def test_tag_found
    assert @tag.find('done'), 'Unable to locate tag "done"'
  end

  def test_tag_not_found
    assert_nil @tag.find('invalid_tag_name'), 'Found tag "invalid_tag_name" (it should not exist)'
  end

  def test_tag_create
    date = DateTime.now.to_s
    assert @tag.create(date).is_a?(Evernote::EDAM::Type::Tag), 'Incorrect datatype for tag.create'
    assert @tag.expunge(date), 'Unable to delete test tag'
  end

end