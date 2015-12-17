require 'minitest/autorun'
require 'evertils/common'

class NoteTest < Minitest::Test
  def test_note_found
    entity = Evertils::Common::Entity::Note.new
    note_name = "ET: This is a test note, I should be deleted"
    entity.create(note_name)

    assert entity.find(note_name)

    entity.expunge(note_name)
  end

  def test_note_not_found
    entity = Evertils::Common::Entity::Note.new

    assert_nil entity.find('kmfj89sdfjnjkern3iurn')
  end
end