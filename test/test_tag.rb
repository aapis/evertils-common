require 'minitest/autorun'
require 'evertils/common'

class TagTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Entity::Tag.new
  end

  def test_tag_found
    assert @entity.find('done'), 'Unable to locate tag "done"'
  end

  def test_tag_not_found
    assert_nil @entity.find('invalid_tag_name'), 'Found tag "invalid_tag_name" (it should not exist)'
  end

  def test_tag_create
    date = DateTime.now.to_s
    tag = @entity.create(date)

    assert tag, 'Tag could not be created'
    assert tag.expunge!, 'Unable to delete test tag'
  end

end