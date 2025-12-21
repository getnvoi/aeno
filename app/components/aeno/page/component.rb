module Aeno::Page
  class Component < Aeno::ApplicationViewComponent
    option(:title)
    option(:subtitle, optional: true)
    option(:description, optional: true)

    renders_one(:actions_area)

    examples("Page", description: "Page layout") do |b|
      b.example(:default, title: "Default") do |e|
        e.preview title: "Page Title", subtitle: "Subtitle", description: "This is a page description" do |page|
          page.with_actions_area do
            render(Aeno::Button::Component.new(label: "Action", variant: :primary))
          end
          "Page content goes here"
        end
      end
    end
  end
end
