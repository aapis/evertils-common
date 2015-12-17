require 'minitest/autorun'
require 'evertils/common'

class NotebookTest < Minitest::Test
    def test_notebook_found
        entity = Evertils::Common::Entity::Notebook.new

        assert entity.find('Programming')
    end

    def test_notebook_not_found
        entity = Evertils::Common::Entity::Notebook.new

        assert_nil entity.find('Invalid Notebook Name')
    end
end