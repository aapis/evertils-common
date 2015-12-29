require 'evertils/test'

class TagTest < Evertils::Test::Base

  def setup
    super

    @entity = Evertils::Common::Entity::Tag.new
  end

  def test_tag_found
    tag = @entity.create('et_done')

    assert @entity.find(tag.prop(:name)), "Unable to locate tag #{tag.prop(:name)}"

    tag.expunge!
  end

  def test_tag_not_found
    assert_nil @entity.find('et_invalid_tag_name'), 'Found tag "et_invalid_tag_name" (it should not exist)'
  end

  def test_tag_create
    date = DateTime.now.to_s
    tag = @entity.create(date)

    assert tag, 'Tag could not be created'
    assert tag.expunge!, 'Unable to delete test tag'
  end

end