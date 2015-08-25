module ApiController
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Copies the required files for ApiControllerGenerator'
      source_root ::File.expand_path('../templates', __FILE__)

      def copy_base_controller
        template "base_controller.rb", "app/controllers/api/base_controller.rb"
      end

      def add_inflection_rule
        insert_into_file "config/initializers/inflections.rb", :after => "# These inflection rules are supported but not enabled by default:\n" do
<<CODE
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'API'
end
CODE
        end
      end
    end
  end
end
