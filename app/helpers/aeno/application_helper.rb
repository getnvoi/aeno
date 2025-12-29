module Aeno
  module ApplicationHelper
    def ui(name, *args, **kwargs, &block)
      component = "Aeno::#{name.to_s.tr('-', '_').camelize}::Component".constantize
      render(component.new(*args, **kwargs), &block)
    end

    # Render a confirm dialog
    # Usage:
    #   confirm_dialog(
    #     title: "Delete Item?",
    #     message: "This action cannot be undone.",
    #     confirm_text: "Delete",
    #     cancel_text: "Cancel",
    #     confirm_url: item_path(item),
    #     confirm_method: :delete,
    #     variant: :destructive
    #   )
    def confirm_dialog(title:, message:, confirm_url:, confirm_text: "Confirm", cancel_text: "Cancel", confirm_method: :post, variant: :destructive)
      dialog_id = "confirm-dialog-#{SecureRandom.hex(4)}"

      render(Aeno::Dialog::Component.new(
        id: dialog_id,
        title: title,
        width: "w-96"
      )) do |dialog|
        dialog.with_footer do
          safe_join([
            button_to(confirm_text, confirm_url,
              method: confirm_method,
              class: "inline-flex items-center justify-center gap-gap text-ui font-weight-ui cursor-pointer h-control px-button-x rounded-button bg-#{variant}-solid hover:bg-#{variant}-hover text-white"
            ),
            content_tag(:button, cancel_text,
              type: "button",
              class: "inline-flex items-center justify-center gap-gap text-ui font-weight-ui cursor-pointer h-control px-button-x rounded-button bg-white hover:bg-secondary-hover text-foreground border border-border",
              data: { action: "click->aeno--dialog#close" }
            )
          ], " ")
        end

        content_tag(:div, class: "p-pad-lg") do
          content_tag(:p, message, class: "text-ui text-foreground")
        end
      end
    end

    # Render flash messages as toasts
    # Usage in layout: <%= render_flash_toasts %>
    def render_flash_toasts
      return unless flash.any?

      flash.map do |type, message|
        variant = case type.to_sym
        when :notice then :success
        when :alert then :error
        when :warning then :warning
        else :default
        end

        ui("toast",
          message: message,
          variant: variant,
          duration: 4000,
          dismissible: true
        )
      end.join.html_safe
    end
  end
end
