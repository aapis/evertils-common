require 'minitest/autorun'
require 'evertils/common'

class TagsTest < Minitest::Test

  def setup
    @entities = Evertils::Common::Entity::Tags.new
  end

  def test_get_all_tags
    assert @entities.all.is_a?(Array)
    assert @entities.all.size > 0
  end

end