module Aeno::Page
  class Component < Aeno::ApplicationViewComponent
    option(:title)
    option(:subtitle, optional: true)
    option(:description, optional: true)

    renders_one(:actions_area)

    examples("Page", description: "Page layout") do |b|
      b.example(:default, title: "Default") do |e|
        e.preview_template title: "Page Title", subtitle: "Subtitle", description: "This is a page description", template: <<~TEMPLATE
          <%= render(Aeno::Page::Component.new(title: "Page Title", subtitle: "Subtitle", description: "This is a page description")) do |page| %>
            <% page.with_actions_area do %>
              <%= ui("button", label: "Action", variant: :primary) %>
            <% end %>
            Page content goes here
          <% end %>
        TEMPLATE
      end
    end
  end
end
