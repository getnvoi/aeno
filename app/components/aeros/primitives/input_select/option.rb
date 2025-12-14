module Aeros::Primitives::InputSelect
  class Option < ::Aeros::ApplicationViewComponent
    option(:value)
    option(:label)
    option(:selected, default: proc { false })
    option(:disabled, default: proc { false })

    erb_template <<~ERB
      <option value="<%= value %>" <%= 'selected' if selected %> <%= 'disabled' if disabled %>>
        <%= label %>
      </option>
    ERB
  end
end
