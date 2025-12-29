module Aeno::Toasts
  class Component < ::Aeno::ApplicationViewComponent
    option(:position, default: proc { "bottom-right" })
    option(:id, default: proc { "toasts-container" })

    style do
      base { "fixed z-[9999] max-w-[24rem] pointer-events-none" }

      variants do
        position do
          bottom_right { "bottom-4 right-4" }
          bottom_left { "bottom-4 left-4" }
          bottom_center { "bottom-4 left-1/2 -translate-x-1/2" }
          top_right { "top-4 right-4" }
          top_left { "top-4 left-4" }
          top_center { "top-4 left-1/2 -translate-x-1/2" }
        end
      end
    end

    erb_template <<~ERB
      <div id="<%= id %>"
           class="<%= style(position:) %>"
           data-controller="<%= controller_name %>"
           data-position="<%= position %>">
        <%= content %>
      </div>
    ERB

    examples("Toasts", description: "Toast notification container") do |b|
      b.example(:basic, title: "Toast Container") do |e|
        e.preview position: :bottom_right do
          "<!-- Toasts will be appended here -->".html_safe
        end
      end
    end
  end
end
