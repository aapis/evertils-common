require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Tag
        
        def initialize
          @evernote = Authentication.new.store

          self
        end

        def find(name)
          @tag = nil
          tags = Tags.new.all

          tags.each do |tag|
            if tag.name == name.to_s
              @tag = tag
            end
          end

          @tag
        end

        def create(name)
          tag = ::Evernote::EDAM::Type::Tag.new
          tag.name = name

          @evernote.createTag(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, tag)
        end

        def expunge(name)
          tag = find(name)

          @evernote.expungeTag(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, tag.guid)
        end

      end
    end
  end
end