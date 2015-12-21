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
    note_manager = Evertils::Common::Entity::Note.new

    assert backup.is_a? Hash
    
    note_manager.expunge(backup[:note].title)
  end
end