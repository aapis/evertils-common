require "evertils/test"

class NotesTest < Evertils::Test::Base
  def setup
    super

    @entities = Evertils::Common::Entity::Notes.new
  end

  def test_notes
    assert @entities.find_all("a test").is_a?(Array), "Incorrect datatype for notes.find_all"
    refute @entities.find_all("a test").empty?, "Incorrect number of results for notes.find_all"
  end

  def test_find_by_tag
    nm = Evertils::Common::Manager::Note.instance
    note = nm.find("Oranges testing") #nm.create(name: "ET: Find by tag (et_test_tag_3)", body: "Test body")
    tag_manager = Evertils::Common::Manager::Tag.instance
    tag = tag_manager.create("tag-#{Time.now.to_i}")
    note.tag(tag)

    assert @entities.find_by_tag(tag.prop(:name)).is_a?(Array), "Incorrect dataype for notes.find_by_tag"
    refute @entities.find_by_tag(tag.prop(:name)).empty?, "Incorrect number of results for notes.find_by_tag"
  end

  def test_find_created_by_date_range
    assert @entities.find_by_date_range(DateTime.new(2015, 01, 01)).is_a?(Array), "Incorrect dataype for notes.find_by_date_range (created)"
    refute @entities.find_by_date_range(DateTime.new(2015, 01, 01)).empty?, "Incorrect number of results for notes.find_by_date_range (created)"
  end

  def test_find_updated_by_date_range
    skip("TODO: enable setting of the updated date when creating a note")
    assert @entities.find_by_date_range(DateTime.new(2015, 01, 01), DateTime.now, :updated).is_a?(Array), "Incorrect dataype for notes.find_by_date_range (updated)"
    refute @entities.find_by_date_range(DateTime.new(2015, 01, 01), DateTime.now, :updated).empty?, "Incorrect number of results for notes.find_by_date_range (updated)"
  end

  def test_find_created_by_date
    nm = Evertils::Common::Manager::Note.instance
    tmp_note = nm.create(name: "ET: Testing find by created date", body: "A body")

    assert @entities.find_by_date(DateTime.now).is_a?(Array), "Incorrect dataype for notes.find_by_date_range (created)"
    refute @entities.find_by_date(DateTime.now).empty?, "Incorrect number of results for notes.find_by_date_range (created)"

    tmp_note.expunge!
  end

  def test_find_updated_by_date
    skip("TODO: enable setting of the updated date when creating a note")
    nm = Evertils::Common::Manager::Note.instance
    tmp_note = nm.create(name: "ET: Testing find by updated date", body: "A body")

    assert @entities.find_by_date(DateTime.now, :updated).is_a?(Array), "Incorrect dataype for notes.find_by_date_range (updated)"
    refute @entities.find_by_date(DateTime.now, :updated).empty?, "Incorrect number of results for notes.find_by_date_range (updated)"

    tmp_note.expunge!
  end
end