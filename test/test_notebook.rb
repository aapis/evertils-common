require 'minitest/autorun'
require 'evertils/common'

class NotebookTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Entity::Notebook.new
  end

  def test_notebook_found
    nb_name = "ET: Sample Notebook"
    @entity.create(nb_name)

    assert @entity.find(nb_name), "Notebook \"#{nb_name}\" not found"

    @entity.expunge(nb_name)
  end
  
end