require 'evertils/common/authentication'
require 'evertils/common/entity/notebooks'

module Evertils
  module Common
    module Entity
      class Stack

        def initialize
          @evernote = Authentication.new.store

          self
        end

        def find(name)
          
        end

        def create_from_yml(full_path)
          if File.exists? full_path
            conf = YAML::load(File.open(full_path))
            required = %w(name children)
            
            if has_required_fields(conf, required)
              if !conf["children"].nil?
                conf["children"].each do |name|
                  create_notebook(name, conf["name"])
                end
              end
            else
              raise ArgumentError, 'Configuration file is missing some required fields'
            end
          else
            raise ArgumentError, "File not found: #{full_path}"
          end
        end

        def create()

        end

        def destroy(name)

        end

      end
    end
  end
end