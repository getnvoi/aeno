module Aeno::Spinner
  class Component < ::Aeno::ApplicationViewComponent
    option(:size, default: proc { :default })
    option(:variant, default: proc { :default })
    option(:css, optional: true)

    style do
      base do
        %w[
          relative
          inset-0
          pl-2
          mr-0
          w-5
          h-5
          before:content-['']
          before:box-border
          before:absolute
          before:top-1/2
          before:left-1/2
          before:w-5
          before:h-5
          before:-mt-2
          before:-ml-2
          before:rounded-full
          before:border-2
          before:animate-spin
        ]
      end

      variants do
        size do
          xs { "before:w-3 before:h-3 before:-mt-1.5 before:-ml-1.5" }
          sm { "before:w-4 before:h-4 before:-mt-2 before:-ml-2" }
          default { "before:w-5 before:h-5 before:-mt-2.5 before:-ml-2.5" }
          lg { "before:w-6 before:h-6 before:-mt-3 before:-ml-3" }
          xl { "before:w-8 before:h-8 before:-mt-4 before:-ml-4" }
        end

        variant do
          default { "before:border-default-solid/50 before:border-t-default-solid" }
          primary { "before:border-primary-solid/50 before:border-t-primary-solid" }
          secondary { "before:border-secondary-solid/50 before:border-t-secondary-solid" }
          destructive { "before:border-destructive-solid/50 before:border-t-destructive-solid" }
        end
      end
    end

    examples("Spinner", description: "Loading indicators") do |b|
      b.example(:default, title: "Default") do |e|
        e.preview
      end

      b.example(:sizes, title: "Sizes") do |e|
        e.preview size: :xs
        e.preview size: :sm
        e.preview size: :default
        e.preview size: :lg
        e.preview size: :xl
      end

      b.example(:variants, title: "Variants") do |e|
        e.preview variant: :default
        e.preview variant: :primary
        e.preview variant: :secondary
        e.preview variant: :destructive
      end
    end

    erb_template <<~ERB
      <span class="<%= style(size:, variant:) %> <%= css %>" data-controller="<%= controller_name %>"></span>
    ERB
  end
end
