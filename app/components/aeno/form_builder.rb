# frozen_string_literal: true

class Aeno::FormBuilder < ActionView::Helpers::FormBuilder
  class BaseComponent < Aeno::ApplicationViewComponent
    INPUT_BASE_CLASSES = %w[
      block
      w-full
      h-control
      px-input-x
      rounded-input
      bg-background-elevated
      text-ui
      text-foreground
      placeholder:text-muted-foreground
      outline-none
      border
      border-border
      focus:ring-2
      focus:ring-primary-solid
      focus:border-primary-solid
    ].freeze

    option(:id, optional: true)
    option(:name)
    option(:value, optional: true)
    option(:disabled, default: proc { false })
    option(:label, optional: true)
    option(:type, optional: true)
    option(:helper_text, optional: true)
    option(:error_text, optional: true)
    option(:placeholder, optional: true)
    option(:required, default: proc { false })
    option(:data, default: proc { {} })
  end

  def field(field_type, name, options = {}, &block)
    klass = "::Aeno::Input::#{field_type.to_s.camelize}::Component".constantize
    resolved_name = resolve_name(name)
    error_text = @object&.errors&.[](name)&.first

    value = options[:value] || @object&.send(name)

    merged_options = options.merge(
      id: options[:id] || "#{@object_name}_#{name}".parameterize(separator: "_"),
      name: resolved_name,
      error_text:,
      value:
    )

    @template.render(klass.new(**merged_options), &block)
  end

  def text_field(name, options = {})
    field(:text, name, options)
  end

  def password_field(name, options = {})
    field(:password, name, options.merge(type: "password"))
  end

  def select_field(name, options = {}, &block)
    field(:select, name, options, &block)
  end

  def text_area_field(name, options = {})
    field(:text_area, name, options)
  end

  def tagging_field(name, options = {})
    field(:tagging, name, options)
  end

  def attachments_field(name, options = {})
    field(:attachments, name, options)
  end

  def text_area_ai_field(name, options = {})
    field(:text_area_ai, name, options)
  end

  def toggle_field(name, options = {})
    field(:toggle, name, options)
  end

  def number_field(name, options = {})
    field(:number, name, options)
  end

  def otp_field(name, options = {})
    field(:otp, name, options)
  end

  def datepicker_field(name, options = {})
    field(:datepicker, name, options)
  end

  def phone_field(name, options = {})
    field(:phone, name, options)
  end

  private

    def resolve_name(name)
      @object_name ? "#{@object_name}[#{name}]" : name
    end
end
