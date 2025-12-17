module Aeno::Form
  class Component < ::Aeno::ApplicationViewComponent
    option :model
    option :url
    option :method, default: proc { :post }

    def render_in(view_context, &block)
      @content_block = block
      super(view_context)
    end

    def render_form_layout(form_builder)
      layout = Aeno::Form::LayoutComponent.new(form_builder: form_builder)
      @content_block.call(layout) if @content_block
      render(layout)
    end

    private

    def form_options
      { data: { controller: "aeno--form" } }
    end

    examples("Form", description: "Form component with integrated form_with") do |b|
      b.example(:basic, title: "Basic Form") do |e|
        e.preview(model: false, url: "/contacts", method: :post) do |component|
          component.with_item_input(type: :text, name: "email", label: "Email")
          component.with_item_input(type: :text, name: "name", label: "Name")
          component.with_submit(label: "Submit", variant: :primary, type: "submit")
        end
      end

      b.example(:with_groups, title: "Form with Groups") do |e|
        e.preview(model: false, url: "/contacts", method: :post) do |component|
          component.with_item_group(title: "Contact Information") do |g|
            g.with_item_input(type: :text, name: "name", label: "Name")
            g.with_item_input(type: :text, name: "email", label: "Email")
          end
          component.with_item_group(title: "Address") do |g|
            g.with_item_row(css: "grid-cols-2") do |r|
              r.with_item_input(type: :text, name: "city", label: "City")
              r.with_item_input(type: :text, name: "state", label: "State")
            end
          end
          component.with_submit(label: "Save", variant: :primary, type: "submit")
          component.with_action(label: "Cancel", variant: :secondary, type: "button")
        end
      end

      b.example(:with_nested, title: "Form with Nested Attributes") do |e|
        e.preview(model: false, url: "/contacts", method: :post) do |component|
          component.with_item_input(type: :text, name: "name", label: "Name")
          component.with_item_input(type: :text, name: "email", label: "Email")

          component.with_item_nested(name: :addresses, label: "Addresses") do |n|
            n.with_item_input(type: :text, name: "street", label: "Street")
            n.with_item_row(css: "grid-cols-2") do |r|
              r.with_item_input(type: :text, name: "city", label: "City")
              r.with_item_input(type: :text, name: "zip", label: "ZIP")
            end
          end

          component.with_submit(label: "Create Contact", variant: :primary, type: "submit")
        end
      end
    end
  end
end
