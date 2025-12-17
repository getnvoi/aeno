module Aeno::Form
  class GroupComponent < ::Aeno::ApplicationViewComponent
    option :title
    option :description, optional: true
    option :form_builder

    renders_many :items, types: {
      input: ->(**args) { Aeno::Input::Component.new(form_builder: form_builder, **args) },
      row: ->(**args) { RowComponent.new(form_builder: form_builder, **args) },
      nested: ->(**args, &block) { NestedComponent.new(form_builder: form_builder, **args, &block) }
    }
  end
end
