require 'minitest/autorun'
require 'evertils/common'

class NoteTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Entity::Note.new
  end

  def test_note_exists
    note_name = "ET: This is a test note, I should be deleted"
    test_note = @entity.create(note_name, 'Test Body')

    assert @entity.exists?(note_name), "Note \"#{note_name}\" does not exist"

    test_note.expunge!
  end

  def test_note_found
    note_name = "ET: Second test note, I should not exist"
    test_note = @entity.create(note_name, 'Test Body')

    assert @entity.find(note_name), "Note \"#{note_name}\" not found"

    test_note.expunge!
  end

  def test_note_share
    note_name = "ET: Shared Note"
    test_note = @entity.create(note_name, 'Test Body')

    assert test_note.share, "Note \"#{note_name}\" was unable to be shared"
  end

  def test_note_unshare
    note_name = "ET: Shared Note"
    test_note = @entity.find(note_name)

    assert test_note, "Shared note does not exist"
    assert_nil test_note.unshare, "Note \"#{note_name}\" could not be unshared"

    test_note.expunge!
  end

  def test_note_destroy
    note_name = "ET: Soft delete this note"
    test_note = @entity.create(note_name, 'Test Body')

    assert test_note.destroy, "Note \"#{note_name}\" was not trashed"

    test_note.expunge!
  end

end