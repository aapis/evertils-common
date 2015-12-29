require 'evertils/test'

class NoteTest < Evertils::Test::Base

  def setup
    super

    @entity = Evertils::Common::Manager::Note.new
  end


  def test_note_found
    note_name = "ET: Second test note, I should not exist"
    test_note = @entity.create(name: note_name, body: 'Test Body')

    assert @entity.find(note_name), "Note \"#{note_name}\" not found"

    test_note.expunge!
  end

  def test_note_tag
    note_name = "ET: Tagged Note"
    test_note = @entity.create(name: note_name, body: 'Test Body')
    tag_manager = Evertils::Common::Manager::Tag.new
    tag = tag_manager.create('et_test_tag')

    assert test_note.tag(tag.prop(:name)), "Note \"#{note_name}\" could not be tagged"

    test_note.expunge!
    tag.expunge!
  end

  def test_note_unshare
    note_name = "ET: Shareable Note"
    test_note = @entity.create(name: note_name, body: 'Test Body')

    assert test_note.share, "Note \"#{note_name}\" was unable to be shared"
    assert_nil test_note.unshare, "Note \"#{note_name}\" could not be unshared"

    test_note.expunge!
  end

  def test_note_destroy
    note_name = "ET: Soft delete this note"
    test_note = @entity.create(name: note_name, body: 'Test Body')

    assert test_note.destroy, "Note \"#{note_name}\" was not trashed"

    test_note.expunge!
  end

  def test_note_move
    note_name = "ET: Move this note"
    test_note = @entity.create(name: note_name, body: 'Test Body')
    nb_entity = Evertils::Common::Manager::Notebook.new

    test_nb = nb_entity.create('Backup2')

    assert test_note.move_to('Backup2'), "Note \"#{note_name}\" could not be moved to target"

    test_nb.expunge!
    test_note.expunge!
  end

end