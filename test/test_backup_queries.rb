require "evertils/test"

class BackupQueriesTest < Evertils::Test::Base
  def setup
    super

    @entity = Evertils::Common::Query::Backup.new
  end

  #
  # @since 0.2.8
  def test_files
    backup = @entity.files(__FILE__)

    assert backup.is_a?(Evertils::Common::Entity::Note), "Invalid datatype for backup.files response"

    backup.expunge!
  end
end