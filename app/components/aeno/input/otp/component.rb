module Aeno::Input::Otp
  class Component < ::Aeno::FormBuilder::BaseComponent
    option(:length, default: proc { 6 })
    option(:pattern, default: proc { "[0-9]" })

    erb_template <<~ERB
      <div class="relative"
           data-controller="aeno--input--otp"
           data-aeno--input--otp-pattern-value="<%= pattern %>"
           data-aeno--input--otp-filled-class="bg-primary-light border-primary-solid">
        <div class="flex gap-gap justify-center">
          <% length.times do %>
            <div class="w-12 h-12 text-center text-2xl border rounded-input bg-background-elevated border-border flex items-center justify-center font-weight-semibold"
                 data-aeno--input--otp-target="box"></div>
          <% end %>
        </div>
        <%= content_tag(:input,
          nil,
          type: "text",
          name: name,
          id: id,
          value: value,
          class: "absolute inset-0 opacity-0 pointer-events-auto",
          autocomplete: "one-time-code",
          inputmode: "numeric",
          maxlength: length,
          data: {
            aeno__input__otp_target: "input",
            action: "input->aeno--input--otp#input paste->aeno--input--otp#paste"
          }
        ) %>
      </div>
    ERB

  end
end
