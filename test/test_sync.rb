require 'minitest/autorun'
require 'evertils/common'

class SyncTest < Minitest::Test
  def test_sync
    entity = Evertils::Common::Entity::Sync.new

    assert entity.state
  end
end