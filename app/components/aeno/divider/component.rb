# frozen_string_literal: true

module Aeno
  module Divider
    class Component < Aeno::ApplicationViewComponent
      option :label, optional: true
      option :orientation, default: -> { :horizontal }
    end
  end
end
