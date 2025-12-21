module Aeno::Sidebar
  class Group < Aeno::ApplicationViewComponent
    option :label

    renders_many :items, Item

    style :container do
      base { "flex w-full min-w-0 flex-col px-0 py-margin-sm" }
    end

    style :label do
      base { "text-muted-foreground h-icon-lg flex items-center px-list text-ui font-weight-ui uppercase tracking-wide" }
    end

    style :menu do
      base { "flex w-full min-w-0 flex-col gap-gap-sm" }
    end

    erb_template <<~ERB
      <div class="<%= style(:container) %>">
        <div class="<%= style(:label) %>"><%= label %></div>
        <ul class="<%= style(:menu) %>">
          <% items.each do |item| %>
            <li><%= item %></li>
          <% end %>
        </ul>
      </div>
    ERB
  end
end
