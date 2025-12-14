module Aeros::Primitives::Table
  class Component < ::Aeros::ApplicationViewComponent
    option(:id, optional: true)

    renders_one :header, "HeaderComponent"
    renders_many :rows, "RowComponent"

    class HeaderComponent < Aeros::ApplicationViewComponent
      renders_many :columns, "ColumnComponent"

      class ColumnComponent < Aeros::ApplicationViewComponent
        erb_template <<~ERB
          <th scope="col" class="cp-table__th <%= css %>"><%= content %></th>
        ERB
      end

      erb_template <<~ERB
        <thead class="cp-table__head">
          <tr>
            <% columns.each do |column| %><%= column %><% end %>
          </tr>
        </thead>
      ERB
    end

    class RowComponent < Aeros::ApplicationViewComponent
      renders_many :cells, "CellComponent"

      class CellComponent < Aeros::ApplicationViewComponent
        erb_template <<~ERB
          <td class="cp-table__td <%= css %>"><%= content %></td>
        ERB
      end

      erb_template <<~ERB
        <tr class="cp-table__tr <%= css %>">
          <% cells.each do |cell| %><%= cell %><% end %>
        </tr>
      ERB
    end
  end
end
