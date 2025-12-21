module Aeno::Sidebar
  class Item < Aeno::ApplicationViewComponent
    option :label
    option :href
    option :icon, optional: true
    option :active, default: proc { false }

    style do
      base do
        %w[
          flex w-full items-center gap-2 rounded-button px-list py-list text-left text-ui
          text-foreground
          hover:bg-secondary-hover
          transition-colors
          [&>svg]:w-4 [&>svg]:h-4 [&>svg]:flex-shrink-0
        ]
      end

      variants do
        active do
          yes { "bg-primary-light font-ui-weight text-primary-solid" }
        end
      end
    end

    def classes
      style(active:)
    end

    erb_template <<~ERB
      <%= link_to(href, class: classes, data: { active: active }) do %>
        <%= lucide_icon(icon) if icon %>
        <span><%= label %></span>
      <% end %>
    ERB
  end
end
