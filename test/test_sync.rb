require 'minitest/autorun'
require 'evertils/common'

class SyncTest < Minitest::Test

  def setup
    @entity = Evertils::Common::Entity::Sync.new
  end

  def test_sync
    assert @entity.state, 'Could not determine sync status'
  end
  
end