module Aeros::Pages::Showcase::Placeholder
  class Component < ::Aeros::ApplicationViewComponent
    option :namespace
    option :id

    def component_name
      id.to_s.titleize
    end
  end
end
