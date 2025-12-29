module Aeno::Empty
  class Component < ::Aeno::ApplicationViewComponent
    option(:icon, optional: true)

    renders_one(:title)
    renders_one(:description)
    renders_many(:actions)

    examples("Empty", description: "Empty state placeholder") do |b|
      b.example(:default, title: "Default") do |e|
        e.preview do |empty|
          empty.with_title { "No items found" }
        end
      end

      b.example(:with_description, title: "With Description") do |e|
        e.preview do |empty|
          empty.with_title { "No items found" }
          empty.with_description { "Try creating a new item to get started" }
        end
      end

      b.example(:with_icon, title: "With Icon") do |e|
        e.preview icon: "inbox" do |empty|
          empty.with_title { "No items found" }
          empty.with_description { "Try creating a new item to get started" }
        end

        e.preview icon: "users" do |empty|
          empty.with_title { "No users yet" }
          empty.with_description { "Invite team members to get started" }
        end
      end

      b.example(:with_actions, title: "With Actions") do |e|
        e.preview_template template: <<~TEMPLATE
          <%= render(Aeno::Empty::Component.new) do |empty| %>
            <% empty.with_title { "No items found" } %>
            <% empty.with_description { "Try creating a new item to get started" } %>
            <% empty.with_action { ui("button", label: "Create Item", variant: :default) } %>
          <% end %>
        TEMPLATE

        e.preview_template icon: "inbox", template: <<~TEMPLATE
          <%= render(Aeno::Empty::Component.new(icon: "inbox")) do |empty| %>
            <% empty.with_title { "No items found" } %>
            <% empty.with_description { "Try creating a new item to get started" } %>
            <% empty.with_action { ui("button", label: "Create Item", variant: :default) } %>
            <% empty.with_action { ui("button", label: "Learn More", variant: :outline) } %>
          <% end %>
        TEMPLATE
      end

      b.example(:complete, title: "Complete Example") do |e|
        e.preview_template icon: "inbox", template: <<~TEMPLATE
          <%= render(Aeno::Empty::Component.new(icon: "inbox")) do |empty| %>
            <% empty.with_title { "No invites yet" } %>
            <% empty.with_description { "Start inviting team members to collaborate on projects" } %>
            <% empty.with_action { ui("button", label: "Send Invite", variant: :default, icon: "mail") } %>
            <% empty.with_action { ui("button", label: "Import from CSV", variant: :outline, icon: "upload") } %>
          <% end %>
        TEMPLATE
      end
    end
  end
end
