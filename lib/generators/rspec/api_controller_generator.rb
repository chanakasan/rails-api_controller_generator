module Rspec
  module Generators
    class ApiControllerGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates an API controller spec in spec/integration/api"

      def copy_template_file
        empty_directory 'spec/integration/api'
        template "api_spec.rb", "spec/integration/api/#{file_name.pluralize}_api_spec.rb"
      end
    end
  end
end
