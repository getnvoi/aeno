# Table Component

Data table component with truncation, sticky columns, row selection, batch actions, and filters.

## Features

- **Default truncation** - All cells truncate long content automatically
- **Sticky columns** - Pin first/last columns while scrolling horizontally
- **Row selection** - Checkboxes embedded in first cell with select all
- **Batch actions** - Actions that appear when rows are selected, auto-merge selected IDs
- **Filters** - Filter controls with auto-merge of filter params

## Basic Usage

```ruby
render Aeno::Table::Component.new do |t|
  t.with_header do |h|
    h.with_column { "Name" }
    h.with_column { "Email" }
  end

  t.with_row do |r|
    r.with_cell { "John Doe" }
    r.with_cell { "john@example.com" }
  end
end
```

## Options

### Table Component

```ruby
Aeno::Table::Component.new(
  sticky: :first,      # Optional: nil, :first, :last, :both
  selectable: true,    # Optional: false (default), true
  css: "custom-class", # Optional: additional CSS classes
  id: "my-table"       # Optional: table ID
)
```

## Sticky Columns

Pin first column, last column, or both while scrolling horizontally.

```ruby
# Sticky first column only
Aeno::Table::Component.new(sticky: :first) do |t|
  t.with_header do |h|
    h.with_column { "ID" }      # Sticky left-0
    h.with_column { "Email" }   # Scrolls
  end
end

# Sticky last column only
Aeno::Table::Component.new(sticky: :last) do |t|
  t.with_header do |h|
    h.with_column { "Name" }    # Scrolls
    h.with_column { "Actions" } # Sticky right-0
  end
end

# Sticky both first and last
Aeno::Table::Component.new(sticky: :both) do |t|
  t.with_header do |h|
    h.with_column { "ID" }      # Sticky left-0
    h.with_column { "Email" }   # Scrolls
    h.with_column { "Actions" } # Sticky right-0
  end
end
```

**CSS Applied:**
- First: `sticky left-0 z-20 bg-white shadow-[2px_0_4px_rgba(0,0,0,0.1)]`
- Last: `sticky right-0 z-20 bg-white shadow-[-2px_0_4px_rgba(0,0,0,0.1)]`

## Row Selection

Enable row selection with checkboxes embedded in the first cell.

```ruby
Aeno::Table::Component.new(selectable: true) do |t|
  t.with_header do |h|
    h.with_column { "Name" }  # Checkbox auto-embedded in header
    h.with_column { "Email" }
  end

  t.with_row(id: "1") do |r|  # ID required for selectable rows
    r.with_cell { "John Doe" }  # Checkbox auto-embedded in first cell
    r.with_cell { "john@example.com" }
  end
end
```

**Behavior:**
- Header checkbox selects/deselects all rows
- Shows indeterminate state when some (but not all) rows are selected
- Individual row checkboxes toggle selection
- Stimulus controller tracks selected IDs

**Row ID Requirement:**
- Each row must have an `id` option when `selectable: true`
- IDs are used to track selection and merge into batch action URLs

## Batch Actions

Actions that appear when rows are selected. Automatically merge selected row IDs into URLs.

### Supported Types

#### Button
```ruby
t.with_action(
  type: :button,
  label: "Delete",
  url: "/contacts/bulk_delete",
  method: :delete,
  variant: :destructive,
  icon: "trash"
)
# Generates: /contacts/bulk_delete?ids[]=1&ids[]=2&ids[]=3
```

#### Select
```ruby
t.with_action(
  type: :select,
  name: "bulk_action",
  url: "/contacts/bulk_action",
  label: "Mark as"
) do |s|
  s.with_option(value: "read", label: "Read")
  s.with_option(value: "unread", label: "Unread")
  s.with_option(value: "archived", label: "Archived")
end
# Generates: /contacts/bulk_action?ids[]=1&ids[]=2&bulk_action=read
```

#### Confirm (Future)
```ruby
t.with_action(
  type: :confirm,
  label: "Delete",
  url: "/contacts/bulk_delete",
  confirm: "Are you sure you want to delete these items?"
)
```

#### Custom
```ruby
t.with_action(type: :custom) do
  render MyCustomComponent.new(...)
end
```

### Validation

- `type` is **REQUIRED**
- Must be one of: `:button`, `:select`, `:confirm`, `:custom`
- Raises `ArgumentError` if missing or invalid

### Batch Toolbar

- **Hidden** when no rows selected
- **Visible** when rows are selected
- Shows selected count: "3 selected"
- Positioned above table with gray background

## Filters

Filter controls that auto-merge filter params into URLs. Always visible (not dependent on selection).

### Search Filter
```ruby
t.with_filter(
  type: :search,
  name: "q",
  url: "/contacts",
  placeholder: "Search...",
  debounce: 300  # milliseconds (default: 300)
)
# Auto-submits as user types: /contacts?q=search_term
```

### Select Filter
```ruby
t.with_filter(
  type: :select,
  name: "status",
  url: "/contacts",
  label: "Status"
) do |s|
  s.with_option(value: "", label: "All")
  s.with_option(value: "active", label: "Active")
  s.with_option(value: "archived", label: "Archived")
end
# Generates: /contacts?status=active&existing_params=preserved
```

### Button Filter
```ruby
t.with_filter(
  type: :button,
  label: "Clear Filters",
  url: "/contacts"
)
```

### Complete Example
```ruby
Aeno::Table::Component.new do |t|
  t.with_filter(type: :search, name: "q", url: "/contacts", placeholder: "Search contacts...")

  t.with_filter(type: :select, name: "status", url: "/contacts", label: "Status") do |s|
    s.with_option(value: "", label: "All")
    s.with_option(value: "active", label: "Active")
  end

  t.with_filter(type: :button, label: "Clear Filters", url: "/contacts")

  t.with_header do |h|
    h.with_column { "Name" }
    h.with_column { "Email" }
  end
end
```

**Supported filter types:** `:search`, `:button`, `:select`, `:confirm`, `:custom`

## Examples Structure

The component includes extensive examples showing all features and variations:

```ruby
examples("Table", description: "Data tables with selection, filters, and sticky columns") do |b|

  # BASIC TABLES
  b.example(:basic, title: "Basic Table") do |e|
    # Minimal - 2 columns, 3 rows
    # With custom CSS
    # With table ID
  end

  b.example(:truncation, title: "Content Truncation") do |e|
    # Short content (no truncation visible)
    # Long content in all columns
    # Mixed short and long content
    # Very long single cell
  end

  # STICKY COLUMNS
  b.example(:sticky_first, title: "Sticky First Column") do |e|
    # 3 columns (ID sticky, 2 scroll)
    # 7 columns (ID sticky, 6 scroll) - wide table
    # With long content to show truncation + sticky
  end

  b.example(:sticky_last, title: "Sticky Last Column") do |e|
    # 3 columns (2 scroll, Actions sticky)
    # 7 columns (6 scroll, Actions sticky) - wide table
  end

  b.example(:sticky_both, title: "Sticky First and Last") do |e|
    # 5 columns (ID sticky left, 3 scroll, Actions sticky right)
    # 10 columns (ID sticky left, 8 scroll, Actions sticky right)
  end

  # ROW SELECTION
  b.example(:selectable, title: "Selectable Rows") do |e|
    # 3 rows
    # 10 rows
    # 20 rows
    # Single row
  end

  b.example(:selectable_sticky, title: "Selectable + Sticky") do |e|
    # Selectable + sticky first
    # Selectable + sticky last
    # Selectable + sticky both
  end

  # BATCH ACTIONS
  b.example(:batch_button, title: "Batch Actions - Buttons") do |e|
    # Single button (delete)
    # Two buttons (delete + export)
    # Three buttons with different variants
  end

  b.example(:batch_select, title: "Batch Actions - Select") do |e|
    # Single select (mark as)
    # Select with 2 options
    # Select with 5+ options
  end

  b.example(:batch_mixed, title: "Batch Actions - Mixed") do |e|
    # Button + Select
    # Multiple buttons + Select
    # Button + Multiple selects
  end

  # FILTERS
  b.example(:filter_search, title: "Filter - Search") do |e|
    # Search with placeholder
    # Search with custom debounce
    # Search with custom name
  end

  b.example(:filter_select, title: "Filter - Select") do |e|
    # Single select (status)
    # Multiple selects (status + category)
    # Select with many options
  end

  b.example(:filter_button, title: "Filter - Button") do |e|
    # Clear filters button
    # Apply filters button
    # Multiple buttons
  end

  b.example(:filter_mixed, title: "Filter - Mixed") do |e|
    # Search + Select
    # Search + Select + Button
    # Search + Multiple selects + Button
  end

  # COMBINED FEATURES
  b.example(:combined_basic, title: "Combined - Selection + Filters") do |e|
    # Selectable + Search filter
    # Selectable + Select filter
    # Selectable + Search + Select + Button
  end

  b.example(:combined_sticky, title: "Combined - Sticky + Selection") do |e|
    # Sticky first + Selectable
    # Sticky both + Selectable + Batch actions
  end

  b.example(:combined_all, title: "Combined - All Features") do |e|
    # Small dataset (5 rows, sticky first, selectable, 1 filter, 1 batch action)
    # Medium dataset (15 rows, sticky both, selectable, 2 filters, 2 batch actions)
    # Large dataset (30 rows, sticky both, selectable, search + 2 selects, 3 batch actions)
  end
end
```

### Preview Structure Examples

Each preview demonstrates specific variations:

**Basic Table:**
```ruby
e.preview do |table|
  table.with_header do |h|
    h.with_column { "Name" }
    h.with_column { "Email" }
  end
  table.with_row { |r| r.with_cell { "John" }; r.with_cell { "john@example.com" } }
  table.with_row { |r| r.with_cell { "Jane" }; r.with_cell { "jane@example.com" } }
end
```

**With Long Content:**
```ruby
e.preview do |table|
  table.with_header do |h|
    h.with_column { "Name" }
    h.with_column { "Description" }
  end
  table.with_row do |r|
    r.with_cell { "Product A" }
    r.with_cell { "This is an extremely long product description that will demonstrate the truncation behavior when text exceeds the available space in the table cell" }
  end
end
```

**Sticky + Selectable + Filters + Batch Actions:**
```ruby
e.preview(sticky: :both, selectable: true) do |table|
  table.with_filter(type: :search, name: "q", url: "/contacts", placeholder: "Search contacts...")
  table.with_filter(type: :select, name: "status", url: "/contacts", label: "Status") do |s|
    s.with_option(value: "", label: "All")
    s.with_option(value: "active", label: "Active")
  end

  table.with_action(type: :button, label: "Delete", url: "/bulk_delete", variant: :destructive)
  table.with_action(type: :select, name: "action", url: "/bulk_action", label: "Action") do |s|
    s.with_option(value: "archive", label: "Archive")
  end

  table.with_header do |h|
    h.with_column { "ID" }
    h.with_column { "Name" }
    h.with_column { "Email" }
    h.with_column { "Status" }
    h.with_column { "Actions" }
  end

  15.times do |i|
    table.with_row(id: (i + 1).to_s) do |r|
      r.with_cell { (i + 1).to_s }
      r.with_cell { "Person #{i + 1}" }
      r.with_cell { "person#{i + 1}@example.com" }
      r.with_cell { ["Active", "Inactive"].sample }
      r.with_cell { "Edit | Delete" }
    end
  end
end
```

## Stimulus Controller

### Targets
- `batchToolbar` - Batch actions container
- `selectedCount` - Selected count text
- `headerCheckbox` - Select all checkbox
- `rowCheckbox` - Individual row checkboxes

### Values
- `selectedIds: Array` - Currently selected row IDs

### Actions
- `toggleAll()` - Select/deselect all rows
- `toggleRow()` - Toggle individual row
- `updateHeaderState()` - Update header checkbox (checked/unchecked/indeterminate)
- `updateBatchToolbar()` - Show/hide batch actions, update count

### Methods
- `buildActionUrl(baseUrl, additionalParams)` - Merge selected IDs into URL

## Component Structure

```
table/
├── component.rb              # Main table component
├── component.html.erb        # Main template
├── controller.js             # Stimulus controller
├── action_component.rb       # Batch action/filter renderer
├── action_component.html.erb # Action template
└── README.md                 # This file
```

## CSS Classes

### Table
- `min-w-full divide-y divide-gray-200` - Base table styles
- `overflow-x-auto` - Wrapper for horizontal scroll

### Cells (default)
- `truncate` - All cells truncate by default
- `px-6 py-4 text-sm text-gray-900` - Padding and text styles

### Header
- `bg-gray-50` - Header background
- `px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider` - Header cell styles

### Sticky Columns
- First: `sticky left-0 z-20 bg-white shadow-[2px_0_4px_rgba(0,0,0,0.1)]`
- Last: `sticky right-0 z-20 bg-white shadow-[-2px_0_4px_rgba(0,0,0,0.1)]`

### Batch Toolbar
- `mb-4 p-4 bg-gray-50 rounded-lg flex items-center justify-between`
- `hidden` - Hidden by default, shown when rows selected
