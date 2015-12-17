require 'minitest/autorun'
require 'evertils/common'

class TagsTest < Minitest::Test
  def test_get_all_tags
    entities = Evertils::Common::Entity::Tags.new

    assert entities.all.is_a?(Array)
    assert entities.all.size > 0
  end
end