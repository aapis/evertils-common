module Evertils
  module Common
    class Authentication

      attr_accessor :store, :shardId, :version

      def initialize
        begin
          if Evertils.token.nil?
            Notify.error("Evernote developer token is not configured properly!\n$EVERTILS_TOKEN == nil")
          end

          userStoreUrl = "https://#{Evertils.host}/edam/user"

          userStoreTransport = Thrift::HTTPClientTransport.new(userStoreUrl)
          userStoreProtocol = Thrift::BinaryProtocol.new(userStoreTransport)
          @@user = ::Evernote::EDAM::UserStore::UserStore::Client.new(userStoreProtocol)

          versionOK = @@user.checkVersion("evernote-data", ::Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR, ::Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)

          @version = "#{::Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR}.#{::Evernote::EDAM::UserStore::EDAM_VERSION_MINOR}"
          @shardId = user.shardId

          if !versionOK
            Notify.error("Evernote API requires an update.  Latest version is #{@version}")
          end

          noteStoreUrl = @@user.getNoteStoreUrl(Evertils.token)

          noteStoreTransport = Thrift::HTTPClientTransport.new(noteStoreUrl)
          noteStoreProtocol = Thrift::BinaryProtocol.new(noteStoreTransport)
          @store = ::Evernote::EDAM::NoteStore::NoteStore::Client.new(noteStoreProtocol)
        rescue Evernote::EDAM::Error::EDAMSystemException => e
          Notify.warning("Problem authenticating, EDAM code #{e.errorCode}")

          case e.errorCode
          when 19
            minutes = (e.rateLimitDuration/60).to_i
            Notify.warning("You are rate limited!  Wait #{minutes} minutes")
            exit(0)
          end
        end
      end

      def info
        {
          :user => "#{user.name} (#{user.username}) - ID##{user.id}",
          :shard => user.shardId,
          :api_version => @version,
        }
      end

      def user
        @@user.getUser(Evertils.token)
      end

      def call(func, *args)
        if args.size > 0
          @store.method(func.to_s).call(Evertils.token, *args)
        else
          @store.method(func.to_s).call(Evertils.token)
        end
      end
    end
  end
end