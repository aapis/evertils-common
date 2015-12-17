require 'minitest/autorun'
require 'evertils/common'

class NoteTest < Minitest::Test
    def test_note_found
        entity = Evertils::Common::Entity::Note.new

        assert entity.find('Integrations')
    end

    def test_note_not_found
        entity = Evertils::Common::Entity::Note.new

        assert_nil entity.find('kmfj89sdfjnjkern3iurn')
    end
end