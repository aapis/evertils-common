require 'singleton'

module Evertils
  module Common
    class Authentication < Common::Generic
      include Singleton

      def initialize
        begin
          # attempt to login as the Evernote user
          prepare_user

          # quit with message if requirements not met
          Notify.error("Evernote developer token is not configured properly!\n$EVERTILS_TOKEN == nil") if Evertils.token.nil?
          Notify.error("Evernote API requires an update.  Latest version is #{@version}") if requires_update

          # prepare the main data model access point
          prepare_note_store
        rescue Evernote::EDAM::Error::EDAMUserException => e
          handle_edam_errors(e)
        rescue Evernote::EDAM::Error::EDAMSystemException => e
          handle_edam_errors(e)
        end
      end

      def info
        {
          :user => "#{@user.name} (#{@user.username}) - ID##{@user.id}",
          :shard => @user.shardId,
          :api_version => @version,
        }
      end

      def call(func, *args)
        begin
          if args.size > 0
            @noteStore.method(func.to_s).call(Evertils.token, *args)
          else
            @noteStore.method(func.to_s).call(Evertils.token)
          end
        rescue Evernote::EDAM::Error::EDAMUserException => e
          handle_edam_errors(e)
        rescue Evernote::EDAM::Error::EDAMSystemException => e
          handle_edam_errors(e)
        end
      end

      def call_user(func, *args)
        begin
          if args.size > 0
            @userStore.method(func.to_s).call(*args)
          else
            @userStore.method(func.to_s).call
          end
        rescue Evernote::EDAM::Error::EDAMUserException => e
          handle_edam_errors(e)
        rescue Evernote::EDAM::Error::EDAMSystemException => e
          handle_edam_errors(e)
        end
      end

      private

      def prepare_user
        userStoreUrl = "https://#{Evertils.host}/edam/user"

        userStoreTransport = Thrift::HTTPClientTransport.new(userStoreUrl)
        userStoreProtocol = Thrift::BinaryProtocol.new(userStoreTransport)
        @userStore = ::Evernote::EDAM::UserStore::UserStore::Client.new(userStoreProtocol)
        @user = call_user(:getUser, Evertils.token)
        @version = "#{::Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR}.#{::Evernote::EDAM::UserStore::EDAM_VERSION_MINOR}"

        if Evertils.is_test?
          Notify.spit "TEST USER: #{info[:user]}"
        end
      end

      def prepare_note_store
        noteStoreUrl = call_user(:getNoteStoreUrl, Evertils.token)

        noteStoreTransport = Thrift::HTTPClientTransport.new(noteStoreUrl)
        noteStoreProtocol = Thrift::BinaryProtocol.new(noteStoreTransport)
        @noteStore = ::Evernote::EDAM::NoteStore::NoteStore::Client.new(noteStoreProtocol)
      end

      def requires_update
        !call_user(:checkVersion, "evernote-data", ::Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR, ::Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)
      end

      private

      def handle_edam_errors(e)
        Notify.warning("Problem authenticating, EDAM code #{e.errorCode}")

        case e.errorCode
        when 1
          message = 'An unknown error occurred'
        when 2
          message = 'The format of the request data was incorrect'
        when 3
          message = 'Not permitted to perform action'
        when 4
          message = 'Unexpected problem with the service'
        when 5
          message = 'A required parameter/field was absent'
        when 6
          message = 'Operation denied due to data model limit'
        when 7
          message = 'Operation denied due to user storage limit'
        when 8
          message = 'Username and/or password incorrect'
        when 9
          message = 'Authentication token expired'
        when 10
          message = 'Change denied due to data model conflict'
        when 11
          message = 'Content of submitted note was malformed'
        when 12
          message = 'Service shard with account data is temporarily down'
        when 13
          message = 'Operation denied due to data model limit, where something such as a string length was too short'
        when 14
          message = 'Operation denied due to data model limit, where something such as a string length was too long'
        when 15
          message = 'Operation denied due to data model limit, where there were too few of something'
        when 16
          message = 'Operation denied due to data model limit, where there were too many of something'
        when 17
          message = 'Operation denied because it is currently unsupported'
        when 18
          message = 'Operation denied because access to the corresponding object is prohibited in response to a take-down notice'
        when 19
          minutes = (e.rateLimitDuration/60).to_i
          message = "You are rate limited!  Wait #{minutes} minutes"
        end

        Notify.warning(message)
        exit(0)
      end

    end
  end
end