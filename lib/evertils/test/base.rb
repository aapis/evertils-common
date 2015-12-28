require 'minitest/autorun'

module Evertils
  module Test
    class Base < Minitest::Test

      def setup
        entity = Evertils::Common::Entity::Sync.new

        if !entity.state.is_a?(Evernote::EDAM::NoteStore::SyncState)
          puts 'Could not determine connection to the Evernote API, exiting'
          exit(1)
        end
      end

    end
  end
end