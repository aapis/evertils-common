require 'minitest/autorun'
require 'evertils/common'

class NotesTest < Minitest::Test

  def setup
    @entities = Evertils::Common::Entity::Notes.new
  end

  def test_notes
    assert @entities.find_all('a test').is_a?(Array)
    assert @entities.find_all('a test').size > 0
  end

end