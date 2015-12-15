module Evertils
  module Common
    class Authentication
      attr_accessor :store, :shardId, :version

      def initialize
        if Evertils::Common::EVERNOTE_DEVELOPER_TOKEN.nil?
          Notify.error("Evernote developer token is not configured properly!\n$EVERTILS_TOKEN == nil")
        end

        userStoreUrl = "https://#{Evertils::Common::EVERNOTE_HOST}/edam/user"

        userStoreTransport = Thrift::HTTPClientTransport.new(userStoreUrl)
        userStoreProtocol = Thrift::BinaryProtocol.new(userStoreTransport)
        @@user = ::Evernote::EDAM::UserStore::UserStore::Client.new(userStoreProtocol)

        versionOK = @@user.checkVersion("evernote-data",
                   ::Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR,
                   ::Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)

        @version = "#{::Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR}.#{::Evernote::EDAM::UserStore::EDAM_VERSION_MINOR}"
        @shardId = user.shardId

        if !versionOK
          Notify.error("Evernote API requires an update.  Latest version is #{@version}")
        end

        noteStoreUrl = @@user.getNoteStoreUrl(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)

        noteStoreTransport = Thrift::HTTPClientTransport.new(noteStoreUrl)
        noteStoreProtocol = Thrift::BinaryProtocol.new(noteStoreTransport)
        @store = ::Evernote::EDAM::NoteStore::NoteStore::Client.new(noteStoreProtocol)
      end

      def info
        {
          :user => "#{user.name} (#{user.username}) - ID##{user.id}",
          :shard => user.shardId,
          :api_version => @version,
        }
      end

      def user
        @@user.getUser(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
      end
    end
  end
end