# frozen_string_literal: true

module Aeno
  module Badge
    class Component < Aeno::ApplicationViewComponent
      option :label
      option :variant, default: -> { :default }
      option :css, optional: true

      style do
        base { "inline-flex items-center px-list py-list text-ui rounded-button" }

        variants do
          variant do
            default { "bg-default-light text-default-dark" }
            primary { "bg-primary-light text-primary-dark" }
            success { "bg-success-light text-success-dark" }
            destructive { "bg-destructive-light text-destructive-dark" }
          end
        end
      end

      def classes
        [
          style(variant:),
          css
        ].compact.join(" ")
      end

      examples("Badge", description: "Small status indicators and labels") do |b|
        b.example(:default, title: "Default") do |e|
          e.preview label: "Badge"
        end

        b.example(:variants, title: "Variants") do |e|
          e.preview variant: :default, label: "Default"
          e.preview variant: :primary, label: "Primary"
          e.preview variant: :success, label: "Success"
          e.preview variant: :destructive, label: "Destructive"
        end

        b.example(:with_text, title: "Status Badges") do |e|
          e.preview variant: :default, label: "Draft"
          e.preview variant: :primary, label: "In Progress"
          e.preview variant: :success, label: "Completed"
          e.preview variant: :destructive, label: "Cancelled"
        end

        b.example(:counts, title: "Count Badges") do |e|
          e.preview variant: :default, label: "0"
          e.preview variant: :primary, label: "5"
          e.preview variant: :success, label: "99+"
          e.preview variant: :destructive, label: "!"
        end
      end
    end
  end
end
