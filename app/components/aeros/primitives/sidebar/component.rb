module Aeros::Primitives::Sidebar
  class Component < Aeros::ApplicationViewComponent
    renders_many(:items, Aeros::Primitives::Sidebar::Item)
    renders_many(:groups, Aeros::Primitives::Sidebar::Group)
    renders_one(:header, Aeros::Primitives::Sidebar::Header)
    renders_one(:footer, Aeros::Primitives::Sidebar::Footer)
  end
end
