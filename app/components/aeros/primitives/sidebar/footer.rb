module Aeros::Primitives::Sidebar
  class Footer < Aeros::ApplicationViewComponent
    erb_template <<~ERB
      <div><%= content %></div>
    ERB
  end
end
