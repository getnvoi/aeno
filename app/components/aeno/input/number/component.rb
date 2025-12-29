module Aeno::Input::Number
  class Component < ::Aeno::FormBuilder::BaseComponent
    option(:min, optional: true)
    option(:max, optional: true)
    option(:step, optional: true)

    erb_template <<~ERB
      <%= content_tag(:input,
        nil,
        type: "number",
        name: name,
        id: id,
        value: value,
        disabled: disabled,
        required: required,
        min: min,
        max: max,
        step: step,
        placeholder: placeholder,
        class: INPUT_BASE_CLASSES.join(" "),
        data: data
      ) %>
    ERB
  end
end
