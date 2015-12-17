require 'minitest/autorun'
require 'evertils/common'

class NotesTest < Minitest::Test
  def test_notes
    entities = Evertils::Common::Entity::Notes.new

    assert entities.findAll('a test').is_a?(Evernote::EDAM::NoteStore::NoteList)
    assert entities.findAll('a test').totalNotes > 0
  end
end