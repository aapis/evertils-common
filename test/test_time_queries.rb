require "evertils/test"

class TimeQueriesTest < Evertils::Test::Base
  def setup
    super

    @entity = Evertils::Common::Query::Time.new
  end

  #
  # @since 0.3.2
  def test_notes_in_range
    refute @entity.notes_in_range(DateTime.new(2015, 01, 01)).empty?, "Not enough notes in the range Jan 1 2015 - NOW"
  end

  #
  # @since 0.3.2
  def test_notes_created_on
    refute @entity.notes_created_on(DateTime.new(2015, 01, 14)).empty?, "No notes created on January 14, 2015"
  end

  #
  # @since 0.3.2
  def test_notes_updated_on
    assert @entity.notes_updated_on(DateTime.new(2015, 01, 14)).empty?, "No notes updated on January 14, 2015"
  end

  #
  # @since 0.3.2
  def test_notebooks_created_in_range
    refute @entity.notebooks_created_in_range(DateTime.new(2015, 01, 01)).empty?, "Not enough notebooks created in the range Jan 1 2015 - NOW"
  end

  #
  # @since 0.3.2
  def test_notebooks_updated_in_range
    refute @entity.notebooks_updated_in_range(DateTime.new(2015, 01, 01)).empty?, "Not enough notebooks updated in the range Jan 1 2015 - NOW"
  end

  #
  # @since 0.3.2
  def test_last_year
    assert @entity.last_year.totalNotes > 0
  end

  #
  # @since 0.3.2
  def test_last_month
    assert @entity.last_month.totalNotes > 0
  end

  #
  # @since 0.3.2
  def test_last_week
    assert @entity.last_week.totalNotes > 0
  end

  #
  # @since 0.3.2
  def test_yesterday
    assert @entity.yesterday.totalNotes > 0
  end
end
