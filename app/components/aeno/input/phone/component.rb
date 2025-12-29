module Aeno::Input::Phone
  class Component < ::Aeno::FormBuilder::BaseComponent
    option(:default_country, default: proc { "us" })
    option(:preferred_countries, default: proc { ["us", "gb", "fr"] })

    erb_template <<~ERB
      <%= content_tag(:input,
        nil,
        type: "tel",
        name: name,
        id: id,
        value: value,
        disabled: disabled,
        required: required,
        placeholder: placeholder,
        class: INPUT_BASE_CLASSES.join(" "),
        data: data.merge(
          controller: "aeno--input--phone",
          "aeno--input--phone-default-country-value": default_country,
          "aeno--input--phone-preferred-countries-value": preferred_countries.to_json
        )
      ) %>
    ERB

  end
end
