module Aeno::Dialog
  class Component < ::Aeno::ApplicationViewComponent
    option(:id, optional: true)
    option(:frame_id, default: proc { "dialog-content" })
    option(:title, optional: true)
    option(:description, optional: true)
    option(:width, default: proc { "w-1/3" })
    option(:actions, optional: true)

    renders_one(:header)
    renders_one(:footer)

    style(:background) do
      base { "fixed inset-0 bg-black/50 opacity-0 pointer-events-none transition-opacity duration-300" }
    end

    style(:wrapper) do
      base { "bg-white rounded-lg shadow-xl opacity-0 scale-95 transition-all duration-300 z-50" }
    end

    style(:inner) do
      base { "max-h-[90vh] min-h-0 flex flex-col" }
    end

    style(:header_default) do
      base { "border-b px-inset py-inset-compact flex items-center justify-between flex-shrink-0" }
    end

    style(:close_button) do
      base { "text-2xl leading-none cursor-pointer text-muted-foreground hover:text-foreground transition-colors" }
    end

    style(:content) do
      base { "flex-1 overflow-y-auto" }
    end

    erb_template <<~ERB
      <div id="<%= id %>" class="fixed inset-0 flex items-center justify-center" data-controller="<%= controller_name %>">
        <!-- Background overlay -->
        <button
          type="button"
          class="<%= style(:background) %>"
          data-action="click-><%= controller_name %>#close"
          data-<%= controller_name %>-target="background"></button>

        <!-- Dialog -->
        <div class="<%= style(:wrapper) %> <%= width %>" data-<%= controller_name %>-target="wrapper">
          <div class="<%= style(:inner) %>">
            <% if header || title %>
              <div class="<%= style(:header_default) %>">
                <div>
                  <% if header %>
                    <%= header %>
                  <% else %>
                    <%= content_tag(:h1, title, class: "text-drawer-title font-weight-drawer-title") if title %>
                    <%= content_tag(:p, description, class: "text-drawer-description text-muted-foreground mt-margin-sm") if description.present? %>
                  <% end %>
                </div>

                <% if actions %>
                  <div><%= actions %></div>
                <% end %>

                <button data-action="click-><%= controller_name %>#close" type="button" class="<%= style(:close_button) %>">
                  <%= lucide_icon("x", class: "w-icon h-icon") %>
                </button>
              </div>
            <% end %>

            <%= turbo_frame_tag(frame_id, class: style(:content)) do %>
              <%= content %>
            <% end %>

            <% if footer %>
              <div class="border-t px-inset py-inset-compact flex items-center justify-end gap-gap-lg flex-shrink-0">
                <%= footer %>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    ERB

    examples("Dialog", description: "Modal dialogs for focused user interactions") do |b|
      b.example(:basic, title: "Basic Dialog") do |e|
        e.preview id: "basic-dialog", title: "Dialog Title", description: "This is a dialog description" do
          '<div class="p-pad-lg"><p>Dialog content goes here</p></div>'.html_safe
        end
      end

      b.example(:with_footer, title: "With Footer Actions") do |e|
        e.preview_template id: "footer-dialog", title: "Confirm Action", template: <<~TEMPLATE
          <%= render(Aeno::Dialog::Component.new(id: "footer-dialog", title: "Confirm Action")) do |dialog| %>
            <% dialog.with_footer do %>
              <%= render(Aeno::Button::Component.new(variant: :destructive, label: "Delete")) %>
              <%= render(Aeno::Button::Component.new(variant: :outline, label: "Cancel", data: { action: "click->aeno--dialog#close" })) %>
            <% end %>
            <div class="p-pad-lg">
              <p>Are you sure you want to delete this item?</p>
            </div>
          <% end %>
        TEMPLATE
      end
    end
  end
end
