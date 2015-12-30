require 'evertils/test'

class NotebookTest < Evertils::Test::Base

  def setup
    super

    @entity = Evertils::Common::Manager::Notebook.new
  end

  def test_notebook_found
    skip("Potentially not required, skipping for now")
    
    nb_name = "ET: Sample Notebook"
    test_notebook = @entity.find_or_create(nb_name)

    assert test_notebook, "Notebook \"#{nb_name}\" not found"

    test_notebook.expunge!
  end
  
end