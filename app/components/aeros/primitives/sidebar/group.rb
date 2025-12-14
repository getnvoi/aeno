module Aeros::Primitives::Sidebar
  class Group < Aeros::ApplicationViewComponent
    option :label

    renders_many :items, Item

    erb_template <<~ERB
      <div class="cp-sidebar-group">
        <div class="cp-sidebar-group__label"><%= label %></div>
        <ul class="cp-sidebar-group__menu">
          <% items.each do |item| %>
            <li><%= item %></li>
          <% end %>
        </ul>
      </div>
    ERB
  end
end
