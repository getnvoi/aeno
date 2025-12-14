module Aeros::Primitives::Sidebar
  class Header < Aeros::ApplicationViewComponent
    erb_template <<~ERB
      <div><%= content %></div>
    ERB
  end
end
