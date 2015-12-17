require 'minitest/autorun'
require 'evertils/common'

class NotesTest < Minitest::Test
    def test_notes
        entities = Evertils::Common::Entity::Notes.new

        assert entities.findAll('a test').is_a?(Array)
        assert entities.findAll('a test').size > 0
    end
end