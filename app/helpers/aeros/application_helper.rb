module Aeros
  module ApplicationHelper
    def page(name, *args, **kwargs, &block)
      component = "Aeros::Pages::#{name.split("/").map(&:camelize).join("::")}::Component".constantize
      render(component.new(*args, **kwargs), &block)
    end

    def ui(name, *args, **kwargs, &block)
      class_name = name.to_s.tr("-", "_").camelize
      component = "Aeros::Primitives::#{class_name}::Component".constantize
      render(component.new(*args, **kwargs), &block)
    end

    def block(name, *args, **kwargs, &blk)
      class_name = name.to_s.tr("-", "_").camelize
      component = "Aeros::Blocks::#{class_name}::Component".constantize
      render(component.new(*args, **kwargs), &blk)
    end
  end
end
