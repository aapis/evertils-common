require 'minitest/autorun'
require 'evertils/common'

class BackupQueriesTest < Minitest::Test
  def setup
    @entity = Evertils::Common::Queries::Simple.new
  end
  
  #
  # @since 0.2.8
  def test_files
    assert @entity.files.is_a? Hash
  end
end