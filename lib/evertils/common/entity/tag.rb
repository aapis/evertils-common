module Evertils
  module Common
    module Entity
      class Tag < Entity::Base

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

          @evernote.call(:createTag, tag)
        end

        def expunge(name)
          tag = find(name)

          @evernote.call(:expungeTag, tag.guid)
        end

      end
    end
  end
end