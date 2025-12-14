module Aeros::Primitives::Card
  class Component < ::Aeros::ApplicationViewComponent
    prop :variant, description: "Card style variant",
         values: [:default, :ghost, :elevated],
         default: -> { :default }
    prop :pad, description: "Padding level (1-4, each = 1rem)", values: [1, 2, 3, 4], optional: true
    prop :centered, description: "Center content with flexbox", default: -> { false }

    def card_classes
      [
        class_for,
        (class_for(:centered) if centered),
        (class_for(variant) if variant != :default),
        ("pad-#{pad}" if pad),
        css
      ].compact.join(" ")
    end
  end
end
