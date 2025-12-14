module Aeros::Pages::Showcase::Show
  class Component < ::Aeros::ApplicationViewComponent
    option :component_class

    def title
      component_class.examples_title || component_name
    end

    def description
      component_class.examples_description
    end

    def examples
      component_class.examples_list
    end

    def props
      component_class.props
    end

    # Returns :primitive or :block
    def component_type
      if component_class.name.include?("::Primitives::")
        :primitive
      elsif component_class.name.include?("::Blocks::")
        :block
      end
    end

    # e.g., "button" from Aeros::Primitives::Button::Component
    def component_name
      component_class.name
        .sub(/^Aeros::(Primitives|Blocks)::/, "")
        .sub(/::Component$/, "")
        .underscore
        .tr("_", "-")
    end

    def render_component(**props)
      case component_type
      when :primitive
        helpers.ui(component_name, **props)
      when :block
        helpers.block(component_name, **props)
      end
    end
  end
end
