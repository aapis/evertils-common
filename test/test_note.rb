require 'minitest/autorun'
require 'evertils/common'

class NoteTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Entity::Note.new
  end

  def test_note_exists
    note_name = "ET: This is a test note, I should be deleted"
    @entity.create(note_name, 'Test Body')

    assert @entity.exists?(note_name), "Note \"#{note_name}\" does not exist"
    refute @entity.exists?("ET: A note that certainly won't exist"), "The non-existent note exists"

    @entity.expunge(note_name)
  end

  def test_note_found
    note_name = "ET: Second test note, I should not exist"
    @entity.create(note_name, 'Test Body')

    assert @entity.find(note_name), "Note \"#{note_name}\" not found"

    @entity.expunge(note_name)
  end

  def test_note_share
    note_name = "ET: Shared Note"
    @entity.create(note_name, 'Test Body')

    assert @entity.share(note_name), "Note \"#{note_name}\" was unable to be shared"
  end

  def test_note_unshare
    note_name = "ET: Shared Note"

    assert_nil @entity.unshare(note_name), "Note \"#{note_name}\" could not be unshared"

    @entity.expunge(note_name)
  end

  def test_note_destroy
    note_name = "ET: Soft delete this note"
    @entity.create(note_name, 'Test Body')

    assert @entity.destroy(note_name), "Note \"#{note_name}\" was not trashed"

    @entity.expunge(note_name)
  end

end