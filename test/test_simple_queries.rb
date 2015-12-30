require 'evertils/test'

class SimpleQueriesTest < Evertils::Test::Base

  def setup
    super

    @entity = Evertils::Common::Query::Simple.new
  end
  
  def test_notebooks
    assert @entity.notebooks.is_a?(Array), 'Incorrect datatype for notebooks.all'
    assert @entity.notebooks.size > 0, 'Incorrect number of results for notebooks.all'
  end

  def test_create_note
    note = @entity.create_note("Sample title", "Sample body")

    refute_nil note, 'Unable to create note "Sample title"'
    assert note.expunge!, 'Unable to destroy note "Sample title"'
  end

  def test_tags
    pass("Not done yet")
  end

  def test_notebook_by_name
    pass("Not done yet")
  end

  def test_notes_by_notebook
    pass("Not done yet")
  end

  def test_create_notebook_by_stack
    pass("Not done yet")
  end

  def test_create_note_from
    pass("Not done yet")
  end

  def test_create_notebooks_from
    pass("Not done yet")
  end

  def test_create_notebook
    pass("Not done yet")
  end

  def test_find_note
    pass("Not done yet")
  end

  def test_note_exists
    pass("Not done yet")
  end

  def test_create_note
    pass("Not done yet")
  end

  def test_destroy_note
    pass("Not done yet")
  end

end