module Evertils
  module Common
    module Entity
      class Tag < Entity::Base

        #
        # @since 0.2.0
        def find(name)
          @entity = nil
          tags = Tags.new.all

          @entity = tags.detect { |tag| tag.name == name }

          self if @entity
        end

        #
        # @since 0.2.0
        def create(name)
          tag = ::Evernote::EDAM::Type::Tag.new
          tag.name = name

          @entity = @evernote.call(:createTag, tag)

          self if @entity
        end

        #
        # @since 0.2.9
        def expunge!
          @evernote.call(:expungeTag, @entity.guid)
        end

        #
        # @since 0.2.0
        # @deprecated 0.2.9
        def expunge(name)
          deprecation_notice('0.2.9', 'Replaced with Entity#expunge!  Will be removed in 0.4.0.')
          tag = find(name)

          @evernote.call(:expungeTag, tag.guid)
        end

      end
    end
  end
end