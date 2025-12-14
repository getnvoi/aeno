module Aeros::Primitives::Dropdown
  class Label < ::Aeros::ApplicationViewComponent
    erb_template <<~ERB
      <div class="cp-dropdown__label"><%= content %></div>
    ERB
  end
end
