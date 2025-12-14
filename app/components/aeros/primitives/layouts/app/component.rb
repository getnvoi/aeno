module Aeros::Primitives::Layouts::App
  class Component < Aeros::ApplicationViewComponent
    renders_one :sidebar, ->(style: nil, &block) {
      Sidebar.new(style: style, &block)
    }
    renders_one :header
    renders_one :aside, ->(style: nil, &block) {
      Aside.new(style: style, &block)
    }

    class Sidebar < Aeros::ApplicationViewComponent
      erb_template <<~ERB
        <aside class="cp-layout-app__sidebar" style="<%= merged_style %>">
          <%= content %>
        </aside>
      ERB
    end

    class Aside < Aeros::ApplicationViewComponent
      erb_template <<~ERB
        <aside class="cp-layout-app__aside" style="<%= merged_style %>">
          <%= content %>
        </aside>
      ERB
    end
  end
end
