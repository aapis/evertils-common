module Evertils
  module Common
    module Converter
      class YamlToEnml < Converter::Base
        
        #
        # @since 0.2.9
        def from_file(path)
          contents = File.open(path, "rb") { |io| io.read }
          obj = YAML::load(contents)

          from_string(obj)
        end

        #
        # @since 0.2.9
        def from_string(yaml)
          builder(yaml)
        end

        private

        #
        # @since 0.2.9
        def builder(obj)
          # hardcoding XML here because it's quick/easy
          # TODO: use some sort of XML builder (not builder gem, it is shite)
          enml = '<?xml version="1.0" encoding="UTF-8"?>'
          enml += '<!DOCTYPE "en-note" SYSTEM "http://xml.evernote.com/pub/enml2.dtd">'
          enml += '<en-note>'
            obj.each do |k, v|
              if v.is_a? Array
                enml += "<p>#{k}</p>"
                enml += "<ul>"
                  v.each do |child|
                    enml += "<li>#{child}</li>"
                  end
                enml += "</ul>"
              else
                enml += "<p>#{k}: #{v}</p>"
              end
            end
          enml += '</en-note>'
          enml
        end

      end
    end
  end
end