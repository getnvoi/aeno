# frozen_string_literal: true

module Aeno
  module Link
    class Component < Aeno::ApplicationViewComponent
      option :label
      option :href
      option :variant, default: -> { :default }
      option :size, default: -> { :base }
      option :css, optional: true

      style do
        base { "text-ui" }

        variants do
          variant do
            default { "text-primary-solid hover:underline" }
            muted { "text-muted-foreground hover:text-foreground" }
            underline { "underline underline-offset-4" }
          end

          size do
            sm { "text-drawer-description" }
            base { "text-ui" }
            lg { "text-page-description" }
          end
        end
      end

      def classes
        [style(variant:, size:), css].compact.join(" ")
      end

      examples("Link", description: "Styled hyperlinks for navigation") do |b|
        b.example(:default, title: "Default") do |e|
          e.preview label: "Click here", href: "#"
        end

        b.example(:variants, title: "Variants") do |e|
          e.preview variant: :default, label: "Default link", href: "#"
          e.preview variant: :muted, label: "Muted link", href: "#"
          e.preview variant: :underline, label: "Underlined link", href: "#"
        end

        b.example(:sizes, title: "Sizes") do |e|
          e.preview size: :sm, label: "Small link", href: "#"
          e.preview size: :base, label: "Base link", href: "#"
          e.preview size: :lg, label: "Large link", href: "#"
        end

        b.example(:combinations, title: "Variant & Size Combinations") do |e|
          e.preview variant: :muted, size: :sm, label: "Small muted", href: "#"
          e.preview variant: :underline, size: :lg, label: "Large underlined", href: "#"
        end
      end
    end
  end
end
