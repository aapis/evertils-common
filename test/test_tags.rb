require "evertils/test"

class TagsTest < Evertils::Test::Base
  def setup
    super

    @entities = Evertils::Common::Entity::Tags.new
  end

  def test_get_all_tags
    tag = Evertils::Common::Manager::Tag.new

    test_tag1 = tag.create("_tag_1")
    test_tag2 = tag.create("_tag_2")
    test_tag3 = tag.create("_tag_3")

    assert @entities.all.is_a?(Array), "Incorrect datatype for tags.all"
    assert @entities.all.size > 0, "Incorrect number of results for tags.all"

    test_tag1.expunge!
    test_tag2.expunge!
    test_tag3.expunge!
  end
end