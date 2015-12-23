require 'minitest/autorun'
require 'evertils/common'

class SimpleQueriesTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Query::Simple.new
  end
  
  def test_notebooks
    assert @entity.notebooks.is_a?(Array), 'Incorrect datatype for notebooks.all'
    assert @entity.notebooks.size > 0, 'Incorrect number of results for notebooks.all'
  end

  def test_create_note
    note = @entity.create_note("Sample title", "Sample body")

    refute_nil note, 'Unable to create note "Sample title"'
    assert @entity.destroy_note(note[:note].title), 'Unable to destroy note "Sample title"'
  end

end