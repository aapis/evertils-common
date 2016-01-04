require 'evertils/test'

class SimpleQueriesTest < Evertils::Test::Base

  def setup
    super

    @entity = Evertils::Common::Query::Simple.new
  end
  
  def test_notebooks
    test_nb = @entity.create_notebook('ET: TEST NB')

    assert @entity.notebooks.is_a?(Array), 'Incorrect datatype for notebooks.all'
    assert @entity.notebooks.size > 0, 'Incorrect number of results for notebooks.all'

    test_nb.expunge!
  end

  def test_tags
    test_tag = @entity.create_tag('et_test_tag_001')

    assert @entity.tags.is_a?(Array), 'Incorrect datatype for notebooks.all'
    assert @entity.tags.size > 0, 'Incorrect number of results for notebooks.all'

    test_tag.expunge!
  end

  def test_notes_by_notebook
    notes = @entity.notes_by_notebook('Default')

    assert notes.is_a?(Array), "Invalid datatype for notes_by_notebook"
    assert notes.size > 0, "Incorrect number of results for notes_by_notebook"
  end

  def test_create_stack_from
    pass("Not done yet")
  end

  def test_create_note_from
    pass("Not done yet")
  end

  def test_create_notebooks_from
    pass("Not done yet")
  end

  def test_create_notebook
    test_nb = @entity.create_notebook('ET: TEST_CREATE_NB')

    assert test_nb, "Test notebook could not be created"

    test_nb.expunge!
  end

  def test_crud_note
    test_note = @entity.create_note('ET: Test Title', 'ET_BODY')

    refute_nil test_note, "Note could not be created"
    assert test_note.find('ET: Test Title'), "Note not found: 'ET: Test Title'"
    assert test_note.expunge!, "Note could note be expunged"
  end

end