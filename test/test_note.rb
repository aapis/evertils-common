require 'evertils/test'

class NoteTest < Evertils::Test::Base
  def setup
    super

    @entity = Evertils::Common::Manager::Note.instance

    note_name = 'Oranges testing'
    @search = @entity.find(note_name)
  end

  def test_note_found
    flunk("#{@search.prop(:title)} not found") unless @search.entity

    assert @search.exists?, "Note \"#{@search.prop(:title)}\" not found"
  end

  def test_note_tag
    tag_manager = Evertils::Common::Manager::Tag.instance
    tag = tag_manager.create("tag-#{Time.now.to_i}")

    flunk("#{@search.prop(:title)} not found") unless @search.entity

    assert @search.tag(tag), "Note \"#{@search.prop(:title)}\" could not be tagged"
  end

  def test_note_unshare
    flunk("#{@search.prop(:title)} not found") unless @search.entity

    assert @search.share, "Note \"#{@search.prop(:title)}\" was unable to be shared"
    assert_nil @search.unshare, "Note \"#{@search.prop(:title)}\" could not be unshared"
  end

  def test_note_destroy
    note_name = "ET: testing destroyable"
    search = @entity.create(title: note_name, body: 'Test Body')

    assert search.destroy, "Note \"#{note_name}\" was not trashed"

    search.expunge!
  end

  def test_note_move
    flunk("#{@search.prop(:title)} not found") unless @search.entity

    assert @search.move_to('Default'), "Note \"#{@search.prop(:title)}\" could not be moved to target"
  end
end