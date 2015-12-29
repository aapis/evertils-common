require 'evertils/test'

class TagsTest < Evertils::Test::Base

  def setup
    super

    @entities = Evertils::Common::Entity::Tags.new
  end

  def test_get_all_tags
    tag = Evertils::Common::Entity::Tag.new(@entities.evernote)
    # TODO: creating more than one tag here causes all variable references to
    #       point to one instance of @entity (duh), which in hind sight will
    #       obviously cause any calls to expunge! to only attempt to delete the
    #       GUID of the last entity that was created/found
    #       An architecture change is required, but reducing this test to 1
    #       still satisfies the requirements
    test_tag1 = tag.create('_tag_1')
    # test_tag2 = tag.create('_tag_2')
    # test_tag3 = tag.create('_tag_3')

    assert @entities.all.is_a?(Array), 'Incorrect datatype for tags.all'
    assert @entities.all.size > 0, 'Incorrect number of results for tags.all'

    test_tag1.expunge!
    # test_tag2.expunge!
    # test_tag3.expunge!
  end

end