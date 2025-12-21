# frozen_string_literal: true

module Aeno
  module AuthCard
    class Component < Aeno::ApplicationViewComponent
      option :title
      option :subtitle, optional: true
      option :max_width, default: -> { :sm }

      renders_one :alert
      renders_one :footer

      def width_class
        case max_width
        when :sm then "max-w-sm"
        when :md then "max-w-md"
        when :lg then "max-w-lg"
        else "max-w-sm"
        end
      end

      examples("Auth Card", description: "Card layout for authentication pages") do |b|
        b.example(:default, title: "Default") do |e|
          e.preview title: "Sign in to your account"
        end

        b.example(:with_subtitle, title: "With Subtitle") do |e|
          e.preview title: "Welcome back", subtitle: "Sign in to continue to your account"
        end

        b.example(:widths, title: "Width Variants") do |e|
          e.preview title: "Small (default)", max_width: :sm
          e.preview title: "Medium", max_width: :md
          e.preview title: "Large", max_width: :lg
        end

        b.example(:with_slots, title: "With Alert and Footer") do |e|
          e.preview_template template: <<~ERB
            <%= render Aeno::AuthCard::Component.new(title: "Sign In", subtitle: "Enter your credentials") do |component| %>
              <% component.with_alert do %>
                <div class="text-ui text-destructive-dark">Invalid credentials</div>
              <% end %>
              <% component.with_footer do %>
                <div class="text-center text-ui">
                  Don't have an account? <a href="#" class="text-primary-solid">Sign up</a>
                </div>
              <% end %>
            <% end %>
          ERB
        end
      end
    end
  end
end
