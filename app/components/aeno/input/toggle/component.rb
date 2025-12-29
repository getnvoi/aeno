module Aeno::Input::Toggle
  class Component < ::Aeno::FormBuilder::BaseComponent
    option(:checked, default: proc { false })

    erb_template <<~ERB
      <div class="group relative inline-flex w-11 shrink-0 rounded-full bg-gray-200 p-0.5 inset-ring inset-ring-gray-900/5 outline-offset-2 outline-indigo-600 transition-colors duration-200 ease-in-out has-[:checked]:bg-indigo-600 has-[:focus-visible]:outline-2 dark:bg-white/5 dark:inset-ring-white/10 dark:outline-indigo-500 dark:has-[:checked]:bg-indigo-500">
        <span class="size-5 rounded-full bg-white shadow-xs ring-1 ring-gray-900/5 transition-transform duration-200 ease-in-out group-has-[:checked]:translate-x-5"></span>
        <%= content_tag(:input,
          nil,
          type: "checkbox",
          name: name,
          id: id,
          checked: checked || value,
          disabled: disabled,
          class: "absolute inset-0 size-full appearance-none focus:outline-hidden",
          "aria-label": label,
          data: data
        ) %>
      </div>
    ERB
  end
end
