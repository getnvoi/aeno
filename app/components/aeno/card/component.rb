module Aeno::Card
  class Component < ::Aeno::ApplicationViewComponent
    style do
      base { "rounded-card border border-border bg-background-elevated" }
    end

    examples("Card", description: "Container with shadow and border") do |b|
      b.example(:default, title: "Default") do |e|
        e.preview css: "px-wrapped py-wrapped"
      end

      b.example(:compact, title: "Compact Padding") do |e|
        e.preview css: "px-list py-list"
      end

      b.example(:large, title: "Large Padding") do |e|
        e.preview css: "px-layout py-layout"
      end
    end
  end
end
