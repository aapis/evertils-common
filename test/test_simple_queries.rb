require 'minitest/autorun'
require 'evertils/common'

class SimpleQueriesTest < Minitest::Test
  def setup
    @entity = Evertils::Common::Query::Simple.new
  end
  
  def test_notebooks
    assert @entity.notebooks.is_a?(Array)
    assert @entity.notebooks.size > 0
  end

  def test_tags
    assert @entity.tags.is_a?(Array)
    assert @entity.tags.size > 0
  end

  def test_create_note
    note = @entity.create_note("Sample title", "Sample body")

    refute_nil note
    assert @entity.destroy_note(note[:note].title)

  end

  def test_tags
    assert @entity.tags.is_a?(Array)
    assert @entity.tags.size > 0
  end
end