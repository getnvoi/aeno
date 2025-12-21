module Aeno::Toast
  class Component < ::Aeno::ApplicationViewComponent
    option :message
    option :variant, default: proc { :default } # :default, :info, :success, :warning, :error
    option :duration, default: proc { 5000 } # milliseconds
    option :dismissible, default: proc { true }

    style do
      base { "pointer-events-auto w-full max-w-sm rounded-card border px-inset py-inset shadow-lg" }

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

    def icon_name
      case variant.to_sym
      when :success then "check-circle"
      when :warning then "alert-triangle"
      when :error then "x-circle"
      when :info then "info"
      else "bell"
      end
    end

    examples("Toast", description: "Temporary notification messages") do |b|
      b.example(:variants, title: "Variants") do |e|
        e.preview variant: :default, message: "This is a default toast"
        e.preview variant: :info, message: "This is an info toast"
        e.preview variant: :success, message: "Successfully completed"
        e.preview variant: :warning, message: "Please review this warning"
        e.preview variant: :error, message: "An error occurred"
      end

      b.example(:durations, title: "Custom Duration") do |e|
        e.preview message: "Quick message (3s)", duration: 3000
        e.preview message: "Standard message (5s)", duration: 5000
        e.preview variant: :success, message: "Persistent message (10s)", duration: 10000
      end

      b.example(:dismissible, title: "Non-dismissible") do |e|
        e.preview message: "This toast cannot be dismissed manually", dismissible: false
      end
    end
  end
end
