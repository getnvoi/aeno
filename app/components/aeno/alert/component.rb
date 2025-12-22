# frozen_string_literal: true

module Aeno
  module Alert
    class Component < Aeno::ApplicationViewComponent
      option :message
      option :variant, default: -> { :default }
      option :title, optional: true
      option :icon, optional: true
      option :dismissible, default: -> { false }

      style do
        base { "rounded-card border px-inset py-inset" }

        variants do
          variant do
            default { "bg-default-light text-default-dark border-default-solid" }
            info { "bg-info-light text-info-dark border-info-solid" }
            success { "bg-success-light text-success-dark border-success-solid" }
            warning { "bg-warning-light text-warning-dark border-warning-solid" }
            error { "bg-destructive-light text-destructive-dark border-destructive-solid" }
          end
        end
      end

      examples("Alert", description: "Display important messages and notifications") do |b|
        b.example(:default, title: "Default") do |e|
          e.preview message: "This is a default alert message"
        end

        b.example(:variants, title: "Variants") do |e|
          e.preview variant: :default, message: "This is a default alert"
          e.preview variant: :info, message: "This is an info alert"
          e.preview variant: :success, message: "This is a success alert"
          e.preview variant: :warning, message: "This is a warning alert"
          e.preview variant: :error, message: "This is an error alert"
        end

        b.example(:with_title, title: "With Title") do |e|
          e.preview title: "Alert Title", message: "This alert has a title"
          e.preview variant: :error, title: "Error Occurred", message: "Something went wrong"
        end

        b.example(:dismissible, title: "Dismissible") do |e|
          e.preview message: "This alert can be dismissed", dismissible: true
          e.preview variant: :warning, message: "Warning: This can be dismissed", dismissible: true
        end

        b.example(:with_icon, title: "With Icon") do |e|
          e.preview icon: "info", message: "This is an info message with an icon"
          e.preview variant: :success, icon: "check-circle", message: "Operation completed successfully"
          e.preview variant: :warning, icon: "alert-triangle", message: "Please review your settings"
          e.preview variant: :error, icon: "x-circle", message: "An error occurred"
        end
      end
    end
  end
end
