require 'rails/generators/erb/scaffold/scaffold_generator'

module Haml
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path("../templates", __FILE__)
      
      def initialize(*args, &block)
        super
        
        # Removing attributes 'title' and 'name' and making them available
        # as @title_attributes.
        @title_attributes = []
        @attributes.select! do |attribute|
          if attribute.name == 'title' || attribute.name == 'name'
            @title_attributes << attribute
            false
          else
            true
          end
        end
        
      end

      def copy_view_files
        available_views.each do |view|
          filename = filename_with_extensions(view)
          template "#{view}.html.haml", File.join("app/views", controller_file_path, filename)
        end
      end

      hook_for :form_builder, :as => :scaffold

      def copy_form_file
        if options[:form_builder].nil?
          filename = filename_with_extensions("_form")
          template "_form.html.haml", File.join("app/views", controller_file_path, filename)
        end
      end

    protected

      def available_views
        %w(index edit show new _list _item)
      end

      def handler
        :haml
      end

    end
  end
end
