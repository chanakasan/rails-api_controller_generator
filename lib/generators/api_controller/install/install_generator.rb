module ApiController
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Copies the required files for ApiControllerGenerator'
      source_root ::File.expand_path('../templates', __FILE__)

      def copy_base_controller
        copy_file "base_controller.rb", "app/controllers/api/base_controller.rb"
      end

      def copy_rspec_helper_file
        empty_directory 'spec/support'
        copy_file "api_helper.rb", "spec/support/api_helper.rb"
      end
    end
  end
end
