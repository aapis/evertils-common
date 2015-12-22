require 'minitest/autorun'
require 'evertils/common'

class NoteTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Entity::Note.new
  end

  def test_note_exists
    note_name = "ET: This is a test note, I should be deleted"
    @entity.create(note_name, 'Test Body')

    assert @entity.exists?(note_name)

    @entity.expunge(note_name)
  end

  def test_note_found
    note_name = "ET: Second test note, I should not exist"
    @entity.create(note_name, 'Test Body')

    assert @entity.find(note_name)

    @entity.expunge(note_name)
  end

  def test_note_not_found
    assert_nil @entity.find('kmfj89sdfjnjkern3iurn')
  end

  def test_note_share
    note_name = "ET: Shared Note"
    @entity.create(note_name, 'Test Body')

    assert @entity.share(note_name)
  end

  def test_note_unshare
    note_name = "ET: Shared Note"

    assert @entity.unshare(note_name)

    @entity.expunge(note_name)
  end

end