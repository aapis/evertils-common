require "evertils/test"

class SimpleQueriesTest < Evertils::Test::Base
  def setup
    super

    @entity = Evertils::Common::Query::Simple.new
    @seed_data_path = File.join(File.dirname(__FILE__), "../lib/evertils/test/seed/")
  end

  def test_notebooks
    test_nb = @entity.create_notebook("ET: TEST NB")

    assert @entity.notebooks.is_a?(Array), "Incorrect datatype for notebooks.all"
    refute @entity.notebooks.empty?, "Incorrect number of results for notebooks.all"

    test_nb.expunge!
  end

  def test_tags
    test_tag = @entity.create_tag("et_test_tag_001")

    assert @entity.tags.is_a?(Array), "Incorrect datatype for notebooks.all"
    refute @entity.tags.empty?, "Incorrect number of results for notebooks.all"

    test_tag.expunge!
  end

  def test_notes_by_notebook
    notes = @entity.notes_by_notebook("Default")

    assert notes.is_a?(Array), "Invalid datatype for notes_by_notebook"
    refute notes.empty?, "Incorrect number of results for notes_by_notebook"
  end

  def test_create_stack_from_yml
    stack_yml = @seed_data_path + "stack.yml"

    assert @entity.create_stack_from_yml(stack_yml), "Unable to create stack from YML"
  end

  def test_create_note_from_yml
    note_yml = @seed_data_path + "note.yml"

    assert @entity.create_note_from_yml(note_yml), "Unable to create note from YML"
  end

  def test_create_notebooks_from
    notebooks_yml = @seed_data_path + "notebooks.yml"

    assert @entity.create_notebooks_from_yml(notebooks_yml), "Unable to create notebooks from YML"
  end

  def test_create_notebook
    test_nb = @entity.create_notebook("ET: TEST_CREATE_NB")

    assert test_nb, "Test notebook could not be created"

    test_nb.expunge!
  end

  def test_create_note_from_hash
    conf = {
      name: "ET: Test Title From Hash",
      body: "ET_BODY"
    }
    test_note = @entity.create_note_from_hash(conf)

    refute_nil test_note, "Note could not be created"
    assert test_note.find("ET: Test Title From Hash"), "Note not found: 'ET: Test Title From Hash'"
    assert test_note.expunge!, "Note could note be expunged"
  end
end