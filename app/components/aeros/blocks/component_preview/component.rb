# frozen_string_literal: true

module Aeros::Blocks::ComponentPreview
  class Component < ::Aeros::ApplicationViewComponent
    option(:title, optional: true)
    option(:description, optional: true)

    def default_style = { height: "300px" }
  end
end
