module Evertils
  module Common
    module Entity
      class Stack < Entity::Base

        def create_from_yml(full_path)
          begin
            nb = Notebook.new

            if File.exists? full_path
              conf = YAML::load(File.open(full_path))
              required = %w(name children)
              
              if has_required_fields(conf, required)
                if !conf["children"].nil?
                  conf["children"].each do |name|
                    nb.create(name, conf["name"])
                  end
                end
              else
                raise ArgumentError, 'Configuration file is missing some required fields'
              end
            else
              raise ArgumentError, "File not found: #{full_path}"
            end
          rescue ArgumentError => e
            puts e.message
          end
        end

      end
    end
  end
end