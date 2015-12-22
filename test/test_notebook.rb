require 'minitest/autorun'
require 'evertils/common'

class NotebookTest < Minitest::Test

  def test_notebook_found
    entity = Evertils::Common::Entity::Notebook.new
    nb_name = "ET: Sample Notebook"
    entity.create(nb_name)

    assert entity.find(nb_name)

    entity.expunge(nb_name)
  end

  def test_notebook_not_found
    entity = Evertils::Common::Entity::Notebook.new

    assert_nil entity.find('ET: Invalid Notebook Name')
  end
  
end