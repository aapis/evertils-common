require 'evertils/test'

class NoteTest < Evertils::Test::Base

  def setup
    super

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

    test_note.expunge!
  end

  def test_note_unshare
    note_name = "ET: Unshared Note (grammar lolz)"
    test_note = @entity.create(note_name, 'Test Body')

    test_note.share

    assert_nil test_note.unshare, "Note \"#{note_name}\" could not be unshared"

    test_note.expunge!
  end

  def test_note_destroy
    note_name = "ET: Soft delete this note"
    test_note = @entity.create(note_name, 'Test Body')

    assert test_note.destroy, "Note \"#{note_name}\" was not trashed"

    test_note.expunge!
  end

  def test_note_move
    note_name = "ET: Move this note"
    test_note = @entity.create(note_name, 'Test Body')

    assert test_note.move_to('Backup'), "Note \"#{note_name}\" could not be moved to target"

    test_note.expunge!
  end

end