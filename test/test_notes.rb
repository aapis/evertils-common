require 'evertils/test'

class NotesTest < Evertils::Test::Base

  def setup
    super

    @entities = Evertils::Common::Entity::Notes.new
  end

  def test_notes
    assert @entities.find_all('a test').is_a?(Array), 'Incorrect datatype for notes.find_all'
    assert @entities.find_all('a test').size > 0, 'Incorrect number of results for notes.find_all'
  end

  def test_find_by_tag
    nm = Evertils::Common::Manager::Note.new
    note = nm.create("ET: Find by tag (et_test_tag_3)", "Test body")
    note.tag('et_test_tag_3')

    assert @entities.find_by_tag('et_test_tag_3').is_a?(Array), 'Incorrect dataype for notes.find_by_tag'
    assert @entities.find_by_tag('et_test_tag_3').size > 0, 'Incorrect number of results for notes.find_by_tag'

    note.expunge!
  end

  def test_find_created_by_date_range
    assert @entities.find_by_date_range(DateTime.new(2015, 01, 01)).is_a?(Array), 'Incorrect dataype for notes.find_by_date_range (created)'
    assert @entities.find_by_date_range(DateTime.new(2015, 01, 01)).size > 0, 'Incorrect number of results for notes.find_by_date_range (created)'
  end

  def test_find_updated_by_date_range
    skip("TODO: enable setting of the updated date when creating a note")
    assert @entities.find_by_date_range(DateTime.new(2015, 01, 01), DateTime.now, :updated).is_a?(Array), 'Incorrect dataype for notes.find_by_date_range (updated)'
    assert @entities.find_by_date_range(DateTime.new(2015, 01, 01), DateTime.now, :updated).size > 0, 'Incorrect number of results for notes.find_by_date_range (updated)'
  end

  def test_find_created_by_date
    nm = Evertils::Common::Manager::Note.new
    tmp_note = nm.create("ET: Testing find by created date", "A body")
    
    assert @entities.find_by_date(DateTime.now).is_a?(Array), 'Incorrect dataype for notes.find_by_date_range (created)'
    assert @entities.find_by_date(DateTime.now).size > 0, 'Incorrect number of results for notes.find_by_date_range (created)'

    tmp_note.expunge!
  end

  def test_find_updated_by_date
    skip("TODO: enable setting of the updated date when creating a note")
    nm = Evertils::Common::Manager::Note.new
    tmp_note = nm.create("ET: Testing find by updated date", "A body")
    
    assert @entities.find_by_date(DateTime.now, :updated).is_a?(Array), 'Incorrect dataype for notes.find_by_date_range (updated)'
    assert @entities.find_by_date(DateTime.now, :updated).size > 0, 'Incorrect number of results for notes.find_by_date_range (updated)'

    tmp_note.expunge!
  end

end