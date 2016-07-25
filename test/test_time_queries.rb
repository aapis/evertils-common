require "evertils/test"

class TimeQueriesTest < Evertils::Test::Base
  def setup
    super

    @entity = Evertils::Common::Query::Time.new
  end

  #
  # @since 0.3.2
  def test_notes_in_range
    skip("Updated queries not supported yet")
    # assert @entity.notes_in_range(DateTime.new(2015, 01, 01)).size > 0, "Not enough notes in the range Jan 1 2015 - NOW"
  end

  #
  # @since 0.3.2
  def test_notes_created_on
    skip("Updated queries not supported yet")
    # assert @entity.created_on(DateTime.new(2015, 01, 14)).size > 0, "No notes created on January 14, 2015"
  end

  #
  # @since 0.3.2
  def test_notes_updated_on
    skip("Updated queries not supported yet")
  end

  #
  # @since 0.3.2
  def test_notebooks_created_in_range
    skip("Updated queries not supported yet")
    # assert @entity.notebooks_created_in_range(DateTime.new(2015, 01, 01)).size > 0, "Not enough notes in the range Jan 1 2015 - NOW"
  end

  #
  # @since 0.3.2
  def test_notebooks_updated_in_range
    skip("Updated queries not supported yet")
  end

  #
  # @since 0.3.2
  def test_last_year
    pass("Test coming")
  end

  #
  # @since 0.3.2
  def test_last_month
    pass("Test coming")
  end

  #
  # @since 0.3.2
  def test_last_week
    pass("Test coming")
  end

  #
  # @since 0.3.2
  def test_yesterday
    pass("Test coming")
  end
end