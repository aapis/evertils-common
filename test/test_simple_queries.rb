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

  end

  def test_notebook_by_name

  end

  def test_notes_by_notebook

  end

  def test_create_notebook_by_stack

  end

  def test_create_note_from

  end

  def test_create_notebooks_from

  end

  def test_create_notebook

  end

  def test_find_note

  end

  def test_note_exists

  end

  def test_create_note

  end

  def test_destroy_note

  end

end