module Aeno::Form
  class RowComponent < ::Aeno::ApplicationViewComponent
    option :css, optional: true
    option :form_builder

    renders_many :items, types: {
      input: ->(**args) { Aeno::Input::Component.new(form_builder: form_builder, **args) }
    }
  end
end
