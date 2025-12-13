module Aeros::Primitives::Button
  class Component < ::Aeros::ApplicationViewComponent
    option(:css, optional: true)
    option(:type, optional: true)
    option(:label, optional: true)
    option(:method, optional: true)
    option(:href, optional: true)
    option(:data, default: proc { {} })
    option(:icon, optional: true)
    option(:variant, default: proc { :default })
    option(:disabled, default: proc { false })
    option(:full, default: proc { false })
    option(:size, default: proc { nil })
    option(:as, default: proc { :button })
    option(:target, optional: true)

    style do
      base do
        %w[
          rounded-button
          px-3.5
          py-2.5
          font-semibold
          inline-flex
          items-center
          space-x-1
          focus-visible:outline
          focus-visible:outline-2
          focus-visible:outline-offset-2
          focus-visible:outline-ring
          cursor-pointer
          transition-colors
          [&>span]:truncate
          [&>span]:flex-shrink
          [&>svg]:flex-shrink-0
          [&>svg]:w-4
          [&>svg]:h-4
          [&.loading]:opacity-50
          [&.loading]:pointer-events-none
          [&.loading_.icon]:hidden
          [&.loading_.spinner]:flex
        ]
      end

      variants do
        variant do
          default { "bg-button hover:bg-button-hover text-button-foreground" }
          secondary { "bg-button-secondary hover:bg-button-secondary-hover text-button-secondary-foreground" }
          destructive { "bg-button-destructive hover:bg-button-destructive-hover text-button-destructive-foreground" }
          outline { "border border-button-border bg-background hover:bg-button-outline-hover text-button-outline-foreground" }
          ghost { "hover:bg-button-ghost-hover text-button-ghost-foreground" }
          link { "text-link underline-offset-4 hover:underline hover:text-link-hover" }
        end

        disabled do
          yes { "pointer-events-none opacity-50" }
        end

        full do
          yes { "w-full justify-center" }
        end

        size do
          xsmall do
            %w[
              px-2.5
              py-1
              text-xs
              rounded-button-sm
              [&>svg]:w-3
              [&>svg]:h-3
              space-x-1
            ]
          end

          small do
            %w[
              px-3
              py-1.5
              text-sm
              rounded-button-sm
              [&>svg]:w-4
              [&>svg]:h-4
              space-x-1
            ]
          end

          large do
            %w[
              px-6
              py-3
              text-lg
              rounded-button-lg
              [&>svg]:w-5
              [&>svg]:h-5
              space-x-2
            ]
          end
        end
      end
    end

    def classes
      [
        css,
        style(variant:, disabled:, full:, size:)
      ].join(" ")
    end

    erb_template <<~ERB
      <% if href %>
        <%= link_to(href, method:, data: merged_data, class: classes, target:) do %>
          <%= lucide_icon(icon, class: "flex-shrink-0 icon") if icon %>
          <%= ui("spinner", size: :sm, variant: :white, css: "spinner hidden") %>
          <% if label %><span class="truncate flex-shrink"><%= label %></span><% end %>
        <% end %>
      <% else %>
        <%= content_tag(as, data: merged_data, type: type || "button", class: classes) do %>
          <%= lucide_icon(icon, class: "flex-shrink-0 icon") if icon %>
          <%= ui("spinner", size: :sm,  variant: :white, css: "spinner hidden") %>
          <% if label %><span class="truncate flex-shrink"><%= label %></span><% end %>
        <% end %>
      <% end %>
    ERB
  end
end
