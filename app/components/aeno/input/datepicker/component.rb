module Aeno::Input::Datepicker
  class Component < ::Aeno::FormBuilder::BaseComponent
    option(:locales, default: proc { ["en-US", "default"] })
    option(:date_format, default: proc { "MM/DD/YYYY" })

    erb_template <<~ERB
      <%= content_tag(:input,
        nil,
        type: "text",
        name: name,
        id: id,
        value: value,
        disabled: disabled,
        required: required,
        placeholder: placeholder || date_format,
        class: INPUT_BASE_CLASSES.join(" "),
        data: data.merge(
          controller: "aeno--input--datepicker",
          "aeno--input--datepicker-locales-value": locales.to_json,
          "aeno--input--datepicker-date-format-value": date_format
        )
      ) %>
    ERB

  end
end
