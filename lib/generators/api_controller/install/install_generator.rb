module ApiController
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Copies the required files for ApiControllerGenerator'
      source_root ::File.expand_path('../templates', __FILE__)

      def copy_base_controller
        template "base_controller.rb", "app/controllers/api/base_controller.rb"
      end
    end
  end
end
