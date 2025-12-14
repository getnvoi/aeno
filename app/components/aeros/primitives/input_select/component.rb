module Aeros::Primitives::InputSelect
  class Component < ::Aeros::FormBuilder::BaseComponent
    option(:prompt, optional: true)
    option(:options, default: proc { [] })
    option(:collection, optional: true)
    option(:value_method, optional: true)
    option(:label_method, optional: true)

    renders_many :select_options, Aeros::Primitives::InputSelect::Option
  end
end
