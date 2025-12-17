module Aeno::Form
  class NestedComponent < ::Aeno::ApplicationViewComponent
    option :name
    option :label, optional: true
    option :form_builder
    option :wrapper_selector, default: proc { ".nested-form-wrapper" }
    option :add_button_label, optional: true
    option :remove_button_label, default: proc { "Remove" }
    option :allow_destroy, default: proc { true }

    def initialize(name:, form_builder:, **options, &block)
      super(name: name, form_builder: form_builder, **options)
      @content_block = block
    end

    def add_label
      add_button_label || "Add #{name.to_s.singularize.titleize}"
    end

    def render_nested_form(builder)
      form = Aeno::Form::Component.new(form_builder: builder)
      @content_block.call(form) if @content_block
      render(form)
    end
  end
end
