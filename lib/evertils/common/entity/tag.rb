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
          tag = ::Evernote::EDAM::Type::Tag.new
          tag.name = name

          @entity = @evernote.call(:createTag, tag)

          self if @entity
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