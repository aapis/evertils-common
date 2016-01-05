require 'evertils/test'

class TimeQueriesTest < Evertils::Test::Base

  def setup
    super
    
    @entity = Evertils::Common::Query::Time.new
  end
  
  #
  # @since 0.3.2
  def test_notes_in_range
    assert @entity.notes_in_range(DateTime.new(2015, 01, 01)).size > 0, "Not enough notes in the range Jan 1 2015 - NOW"
  end

  #
  # @since 0.3.2
  def test_notes_created_on
    pass('Test coming')
  end

  #
  # @since 0.3.2
  def test_notes_updated_on
    skip('Updated queries not supported yet')
  end

  #
  # @since 0.3.2
  def test_notebooks_created_in_range
    pass('Test coming')
  end

  #
  # @since 0.3.2
  def test_notebooks_updated_in_range
    pass('Test coming')
  end

  #
  # @since 0.3.2
  def test_last_year
    pass('Test coming')
  end

  #
  # @since 0.3.2
  def test_last_month
    pass('Test coming')
  end

  #
  # @since 0.3.2
  def test_last_week
    pass('Test coming')
  end

  #
  # @since 0.3.2
  def test_yesterday
    pass('Test coming')
  end
  
end