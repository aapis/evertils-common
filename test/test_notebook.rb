require 'minitest/autorun'
require 'evertils/common'

class NotebookTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Entity::Notebook.new
  end

  def test_notebook_found
    nb_name = "ET: Sample Notebook"
    test_notebook = @entity.create(nb_name)

    assert test_notebook, "Notebook \"#{nb_name}\" not found"

    test_notebook.expunge!
  end
  
end