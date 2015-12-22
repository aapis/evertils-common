require 'minitest/autorun'
require 'evertils/common'

class NotesTest < Minitest::Test

  def setup
    @entities = Evertils::Common::Entity::Notes.new
  end

  def test_notes
    assert @entities.find_all('a test').is_a?(Evernote::EDAM::NoteStore::NoteList)
    assert @entities.find_all('a test').totalNotes > 0
  end

end