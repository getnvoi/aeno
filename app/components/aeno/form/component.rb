module Aeno::Form
  class Component < ::Aeno::ApplicationViewComponent
    option :form_builder

    renders_many :items, types: {
      input: ->(**args) { Aeno::Input::Component.new(form_builder: form_builder, **args) },
      group: ->(**args) { GroupComponent.new(form_builder: form_builder, **args) },
      row: ->(**args) { RowComponent.new(form_builder: form_builder, **args) },
      nested: ->(**args, &block) { NestedComponent.new(form_builder: form_builder, **args, &block) }
    }

    renders_one :submit, Aeno::Button::Component
    renders_one :action, Aeno::Button::Component

    examples("Form", description: "Form with ViewComponent polymorphic slots") do |b|
      b.example(:slots, title: "Clean polymorphic slot DSL") do |e|
        e.preview url: "/contacts", method: :post, debug: true do |component|
          component.with_item_input(type: :text, name: "email", label: "Email")

          component.with_item_group(title: "Contact Information") do |g|
            g.with_item_input(type: :text, name: "name", label: "Name")

            g.with_item_nested(name: :siblings, label: "Siblings") do |s|
              s.with_item_input(type: :text, name: "name", label: "Sibling Name")
              s.with_item_input(type: :text, name: "age", label: "Age")

              s.with_item_nested(name: :phones, label: "Phone Numbers") do |p|
                p.with_item_input(type: :text, name: "number", label: "Number")
                p.with_item_input(type: :select, name: "type", label: "Type") do |select|
                  select.with_option(value: "mobile", label: "Mobile")
                  select.with_option(value: "home", label: "Home")
                end
              end
            end
          end

          component.with_item_group(title: "Address") do |g|
            g.with_item_row(css: "grid-cols-2") do |r|
              r.with_item_input(type: :text, name: "city", label: "City")
              r.with_item_input(type: :text, name: "state", label: "State")
            end
          end

          component.with_submit(label: "Create Contact", variant: :primary, type: "submit")
          component.with_action(label: "Cancel", variant: :secondary, type: "button")
        end
      end
    end
  end
end
