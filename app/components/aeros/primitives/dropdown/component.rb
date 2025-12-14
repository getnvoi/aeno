module Aeros::Primitives::Dropdown
  class Component < ::Aeros::ApplicationViewComponent
    prop :placement, description: "Dropdown position",
         values: [:top, :bottom, :left, :right],
         default: -> { :bottom }
    prop :strategy, description: "Positioning strategy",
         values: [:absolute, :fixed],
         default: -> { :absolute }
    prop :searchable, description: "Enable search input", default: -> { false }
    prop :placeholder, description: "Search placeholder", default: -> { "Search..." }

    renders_one :trigger
    renders_many :items, types: {
      item: {
        renders: ->(**opts, &block) { Item.new(**opts, &block) },
        as: :item
      },
      label: {
        renders: ->(**opts, &block) { Label.new(**opts, &block) },
        as: :label
      },
      separator: {
        renders: -> { Separator.new },
        as: :separator
      },
      radio_group: {
        renders: ->(**opts, &block) { RadioGroup.new(**opts, &block) },
        as: :radio_group
      },
      checkbox: {
        renders: ->(**opts, &block) { Checkbox.new(**opts, &block) },
        as: :checkbox
      }
    }
  end
end
