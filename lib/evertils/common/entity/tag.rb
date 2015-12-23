module Evertils
  module Common
    module Entity
      class Tag < Entity::Base

        def find(name)
          @entity = nil
          tags = Tags.new.all

          tags.each do |tag|
            if tag.name == name.to_s
              @entity = tag
            end
          end

          self if @entity
        end

        def create(name)
          @entity = ::Evernote::EDAM::Type::Tag.new
          @entity.name = name

          @evernote.call(:createTag, @entity)
        end

        def expunge!
          @evernote.call(:expungeTag, @entity.guid)
        end

        def expunge(name)
          deprecation_notice('0.2.9')
          tag = find(name)

          @evernote.call(:expungeTag, tag.guid)
        end

      end
    end
  end
end