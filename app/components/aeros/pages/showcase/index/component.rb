module Aeros::Pages::Showcase::Index
  class Component < ::Aeros::ApplicationViewComponent
    def component_class(name)
      "Aeros::Primitives::#{name.to_s.camelize}::Component".constantize
    end
  end
end
