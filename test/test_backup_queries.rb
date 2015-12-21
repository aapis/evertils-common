require 'minitest/autorun'
require 'evertils/common'

class BackupQueriesTest < Minitest::Test
  def setup
    @entity = Evertils::Common::Query::Backup.new
  end
  
  #
  # @since 0.2.8
  def test_files
    backup = @entity.files(__FILE__)

    assert backup.is_a? Hash
  end
end