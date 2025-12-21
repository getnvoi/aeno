# Aeno Theme System

Flat, semantic token system using Tailwind CSS v4's `@theme` directive. Base color palette (solid/light/dark variants) defines the app's look and feel. All other tokens derive from these base colors.

## Full Theme Tokens

```css
@theme {
  /* ==========================================================================
     BASE COLOR PALETTE - Top-level colors that define the app's look & feel
     ========================================================================== */

  /* PRIMARY (Blue) - Main actions, links, focus states */
  --color-primary-solid: #2563eb;      /* blue-600 - buttons, emphasis */
  --color-primary-light: #eff6ff;      /* blue-50 - alert/badge bg */
  --color-primary-dark: #1e3a8a;       /* blue-900 - text on light bg */

  /* SECONDARY (Slate) - Neutral actions, default text */
  --color-secondary-solid: #475569;    /* slate-600 - muted emphasis */
  --color-secondary-light: #f8fafc;    /* slate-50 - page background */
  --color-secondary-dark: #0f172a;     /* slate-900 - body text */

  /* DESTRUCTIVE (Red) - Dangerous actions, errors */
  --color-destructive-solid: #dc2626;  /* red-600 - delete buttons */
  --color-destructive-light: #fef2f2;  /* red-50 - error alert bg */
  --color-destructive-dark: #7f1d1d;   /* red-900 - error text */

  /* SUCCESS (Green) - Success states, confirmations */
  --color-success-solid: #16a34a;      /* green-600 - success buttons */
  --color-success-light: #f0fdf4;      /* green-50 - success alert bg */
  --color-success-dark: #14532d;       /* green-900 - success text */

  /* WARNING (Amber) - Warning states, cautions */
  --color-warning-solid: #d97706;      /* amber-600 - warning emphasis */
  --color-warning-light: #fffbeb;      /* amber-50 - warning alert bg */
  --color-warning-dark: #78350f;       /* amber-900 - warning text */

  /* INFO (Sky) - Informational states */
  --color-info-solid: #0284c7;         /* sky-600 - info emphasis */
  --color-info-light: #f0f9ff;         /* sky-50 - info alert bg */
  --color-info-dark: #0c4a6e;          /* sky-900 - info text */

  /* DEFAULT (Slate) - Neutral/default states */
  --color-default-solid: #64748b;      /* slate-500 - default emphasis */
  --color-default-light: #f8fafc;      /* slate-50 - default alert bg */
  --color-default-dark: #475569;       /* slate-600 - default text */

  /* ==========================================================================
     SEMANTIC TOKENS - Derive from base palette
     ========================================================================== */

  /* Global application colors */
  --color-background: var(--color-secondary-light);        /* slate-50 */
  --color-background-elevated: #ffffff;                    /* white for cards/drawers */
  --color-foreground: var(--color-secondary-dark);         /* slate-900 */
  --color-border: #e2e8f0;                                 /* slate-200 */
  --color-muted-foreground: #64748b;                       /* slate-500 */

  /* Opacities */
  --opacity-muted: 0.6;
  --opacity-disabled: 0.5;

  /* Button hover states */
  --color-primary-hover: #1d4ed8;                          /* blue-700 */
  --color-secondary-hover: #f1f5f9;                        /* slate-100 */
  --color-destructive-hover: #b91c1c;                      /* red-700 */
  --color-success-hover: #15803d;                          /* green-700 */
  --color-warning-hover: #b45309;                          /* amber-700 */
  --color-info-hover: #0369a1;                             /* sky-700 */

  /* ==========================================================================
     SPACING SYSTEM
     ========================================================================== */

  /* List spacing - Compact vertical lists (sidebar, dropdown, table) */
  --spacing-list-x: 1rem;              /* 16px */
  --spacing-list-y: 0.5rem;            /* 8px */

  /* Layout spacing - Page containers, sections */
  --spacing-layout-x: 2rem;            /* 32px */
  --spacing-layout-y: 1.5rem;          /* 24px */

  /* Wrapped spacing - Cards, drawers, modals */
  --spacing-wrapped-x: 1.5rem;         /* 24px */
  --spacing-wrapped-y: 1.5rem;         /* 24px */
  --spacing-wrapped-title-y: 0.75rem;  /* 12px - HALF of wrapped-x */

  /* ==========================================================================
     TYPOGRAPHY SYSTEM
     ========================================================================== */

  /* UI text - Buttons, labels, table cells, form fields */
  --text-ui: 0.875rem;                 /* 14px */
  --text-ui-line-height: 1.25rem;      /* 20px */
  --font-ui-weight: 500;

  /* Page typography - Main content headings */
  --text-page-title: 1.875rem;         /* 30px */
  --text-page-title-line-height: 2.25rem;
  --font-page-title-weight: 700;
  --text-page-description: 1rem;       /* 16px */
  --text-page-description-line-height: 1.5rem;

  /* Drawer typography - Modal/drawer headings */
  --text-drawer-title: 1.125rem;       /* 18px */
  --text-drawer-title-line-height: 1.75rem;
  --font-drawer-title-weight: 600;
  --text-drawer-description: 0.875rem; /* 14px */
  --text-drawer-description-line-height: 1.25rem;

  /* ==========================================================================
     CONTROL SIZING - Buttons, Inputs, Selects
     ========================================================================== */

  /* Control heights */
  --height-control: 2.5rem;            /* 40px - default */
  --height-control-sm: 2rem;           /* 32px */
  --height-control-lg: 3rem;           /* 48px */

  /* Button padding */
  --spacing-button-x: 1rem;            /* 16px */
  --spacing-button-x-sm: 0.75rem;      /* 12px */
  --spacing-button-x-lg: 1.5rem;       /* 24px */

  /* Input padding */
  --spacing-input-x: 0.75rem;          /* 12px */
  --spacing-input-x-sm: 0.625rem;      /* 10px */
  --spacing-input-x-lg: 1rem;          /* 16px */

  /* ==========================================================================
     BORDER RADIUS
     ========================================================================== */

  /* Buttons */
  --radius-button: 0.375rem;           /* 6px */
  --radius-button-sm: 0.25rem;         /* 4px */
  --radius-button-lg: 0.5rem;          /* 8px */

  /* Inputs */
  --radius-input: 0.375rem;            /* 6px */
  --radius-input-sm: 0.25rem;          /* 4px */
  --radius-input-lg: 0.5rem;           /* 8px */

  /* Cards */
  --radius-card: 0.5rem;               /* 8px */
  --radius-card-sm: 0.375rem;          /* 6px */
  --radius-card-lg: 0.75rem;           /* 12px */
}
```

## Generated Utility Classes

Tailwind v4 automatically generates utilities from `--color-*`, `--spacing-*`, `--text-*`, etc. tokens.

### Base Color Palette Classes

**Primary (Blue)**
- `bg-primary-solid`, `text-primary-solid`, `border-primary-solid`, `ring-primary-solid`, `accent-primary-solid`
- `bg-primary-light`, `text-primary-light`, `border-primary-light`
- `bg-primary-dark`, `text-primary-dark`, `border-primary-dark`
- `bg-primary-hover`, `text-primary-hover`, `border-primary-hover`

**Secondary (Slate)**
- `bg-secondary-solid`, `text-secondary-solid`, `border-secondary-solid`
- `bg-secondary-light`, `text-secondary-light`, `border-secondary-light`
- `bg-secondary-dark`, `text-secondary-dark`, `border-secondary-dark`

**Destructive (Red)**
- `bg-destructive-solid`, `text-destructive-solid`, `border-destructive-solid`, `ring-destructive-solid`, `accent-destructive-solid`
- `bg-destructive-light`, `text-destructive-light`, `border-destructive-light`
- `bg-destructive-dark`, `text-destructive-dark`, `border-destructive-dark`
- `bg-destructive-hover`, `text-destructive-hover`, `border-destructive-hover`

**Success (Green)**
- `bg-success-solid`, `text-success-solid`, `border-success-solid`, `ring-success-solid`, `accent-success-solid`
- `bg-success-light`, `text-success-light`, `border-success-light`
- `bg-success-dark`, `text-success-dark`, `border-success-dark`
- `bg-success-hover`, `text-success-hover`, `border-success-hover`

**Warning (Amber)**
- `bg-warning-solid`, `text-warning-solid`, `border-warning-solid`, `ring-warning-solid`
- `bg-warning-light`, `text-warning-light`, `border-warning-light`
- `bg-warning-dark`, `text-warning-dark`, `border-warning-dark`
- `bg-warning-hover`, `text-warning-hover`, `border-warning-hover`

**Info (Sky)**
- `bg-info-solid`, `text-info-solid`, `border-info-solid`, `ring-info-solid`
- `bg-info-light`, `text-info-light`, `border-info-light`
- `bg-info-dark`, `text-info-dark`, `border-info-dark`
- `bg-info-hover`, `text-info-hover`, `border-info-hover`

**Default (Slate)**
- `bg-default-solid`, `text-default-solid`, `border-default-solid`
- `bg-default-light`, `text-default-light`, `border-default-light`
- `bg-default-dark`, `text-default-dark`, `border-default-dark`

### Semantic Color Classes

- `bg-background`, `text-background` (page background - slate-50)
- `bg-background-elevated`, `text-background-elevated` (cards/drawers - white)
- `bg-foreground`, `text-foreground`, `border-foreground` (body text - slate-900)
- `bg-border`, `text-border`, `border-border` (borders - slate-200)
- `text-muted-foreground` (muted text - slate-500)

### Spacing Classes

**List** (Sidebar, Dropdown, Table cells)
- `px-list` (16px), `py-list` (8px)

**Layout** (Page containers)
- `px-layout` (32px), `py-layout` (24px)

**Wrapped** (Cards, Drawers)
- `px-wrapped` (24px), `py-wrapped` (24px), `py-wrapped-title` (12px)

### Typography Classes

**UI** (Buttons, Labels, Table cells)
- `text-ui` (14px), `leading-ui` (20px), `font-ui-weight` (500)

**Page** (Main content)
- `text-page-title` (30px), `leading-page-title` (36px), `font-page-title-weight` (700)
- `text-page-description` (16px), `leading-page-description` (24px)

**Drawer** (Modal headers)
- `text-drawer-title` (18px), `leading-drawer-title` (28px), `font-drawer-title-weight` (600)
- `text-drawer-description` (14px), `leading-drawer-description` (20px)

### Control Sizing Classes

**Heights**
- `h-control` (40px), `h-control-sm` (32px), `h-control-lg` (48px)

**Button Padding**
- `px-button-x` (16px), `px-button-x-sm` (12px), `px-button-x-lg` (24px)

**Input Padding**
- `px-input-x` (12px), `px-input-x-sm` (10px), `px-input-x-lg` (16px)

### Border Radius Classes

**Buttons**
- `rounded-button` (6px), `rounded-button-sm` (4px), `rounded-button-lg` (8px)

**Inputs**
- `rounded-input` (6px), `rounded-input-sm` (4px), `rounded-input-lg` (8px)

**Cards**
- `rounded-card` (8px), `rounded-card-sm` (6px), `rounded-card-lg` (12px)

## Component Usage Examples

### Button Component

**Variants: primary, outline, destructive**
**Sizes: default, xs, xl**

```ruby
# Primary (default size)
class: "h-control px-button-x text-ui font-ui-weight rounded-button
        bg-primary-solid text-white hover:bg-primary-hover"

# Outline (default size)
class: "h-control px-button-x text-ui font-ui-weight rounded-button
        bg-white text-foreground border border-border hover:bg-secondary-hover"

# Destructive (default size)
class: "h-control px-button-x text-ui font-ui-weight rounded-button
        bg-destructive-solid text-white hover:bg-destructive-hover"

# XS size (primary)
class: "h-control-sm px-button-x-sm text-ui font-ui-weight rounded-button-sm
        bg-primary-solid text-white hover:bg-primary-hover"

# XL size (primary)
class: "h-control-lg px-button-x-lg text-ui font-ui-weight rounded-button-lg
        bg-primary-solid text-white hover:bg-primary-hover"

# Disabled (any variant)
class: "opacity-disabled pointer-events-none"
```

### Alert Component

**Variants: default, info, success, warning, error**

```ruby
# Default alert
class: "rounded-card border px-wrapped py-wrapped
        bg-default-light text-default-dark border-default-solid"

# Info alert
class: "rounded-card border px-wrapped py-wrapped
        bg-info-light text-info-dark border-info-solid"

# Success alert
class: "rounded-card border px-wrapped py-wrapped
        bg-success-light text-success-dark border-success-solid"

# Warning alert
class: "rounded-card border px-wrapped py-wrapped
        bg-warning-light text-warning-dark border-warning-solid"

# Error alert
class: "rounded-card border px-wrapped py-wrapped
        bg-destructive-light text-destructive-dark border-destructive-solid"

# With icon (optional)
# Icon uses same text color, wrapped in flex layout
```

### Badge Component

**Variants: default, primary, success, destructive**

```ruby
# Default badge
class: "inline-flex items-center px-list py-list text-ui rounded-button
        bg-default-light text-default-dark"

# Primary badge
class: "inline-flex items-center px-list py-list text-ui rounded-button
        bg-primary-light text-primary-dark"

# Success badge
class: "inline-flex items-center px-list py-list text-ui rounded-button
        bg-success-light text-success-dark"

# Destructive badge
class: "inline-flex items-center px-list py-list text-ui rounded-button
        bg-destructive-light text-destructive-dark"
```

### Input Component

```ruby
# Text input
class: "h-control px-input-x text-ui rounded-input
        bg-background-elevated text-foreground border border-border
        focus:ring-2 focus:ring-primary-solid focus:border-primary-solid
        placeholder:text-muted-foreground"

# Input with error
class: "h-control px-input-x text-ui rounded-input
        bg-background-elevated text-foreground border border-destructive-solid
        focus:ring-2 focus:ring-destructive-solid focus:border-destructive-solid"

# Disabled input
class: "h-control px-input-x text-ui rounded-input
        bg-background-elevated text-foreground border border-border
        opacity-disabled pointer-events-none"
```

### Card Component

```ruby
# Card
class: "rounded-card border border-border bg-background-elevated px-wrapped py-wrapped"

# Card with header
class: "rounded-card border border-border bg-background-elevated"

# Card header
class: "px-wrapped py-wrapped-title border-b border-border"

# Card title
class: "text-drawer-title font-drawer-title-weight text-foreground"

# Card body
class: "px-wrapped py-wrapped"
```

### Drawer Component

```ruby
# Drawer container
class: "bg-background-elevated border-l border-border"

# Drawer header
class: "px-wrapped py-wrapped-title border-b border-border bg-background-elevated"

# Drawer title
class: "text-drawer-title leading-drawer-title font-drawer-title-weight text-foreground"

# Drawer description
class: "text-drawer-description leading-drawer-description text-muted-foreground"

# Drawer body
class: "px-wrapped py-wrapped bg-background-elevated"

# Drawer footer
class: "px-wrapped py-wrapped border-t border-border bg-background-elevated"
```

### Table Component

```ruby
# Table container
class: "rounded-card border border-border bg-background-elevated"

# Table header cell
class: "px-wrapped py-list text-ui font-ui-weight text-muted-foreground border-b border-border"

# Table cell (with bottom border for row dividers)
class: "px-wrapped py-list text-ui text-foreground border-b border-border"

# Table cell (with full borders for grid)
class: "px-wrapped py-list text-ui text-foreground border border-border"
```

### Sidebar Component

```ruby
# Sidebar container
class: "bg-background-elevated border-r border-border"

# Sidebar item
class: "px-list py-list text-ui text-foreground hover:bg-secondary-light rounded-button"

# Sidebar item (active)
class: "px-list py-list text-ui text-primary-solid bg-primary-light rounded-button"
```

### Checkbox/Radio Components

```ruby
# Checkbox
class: "h-5 w-5 rounded-button-sm border border-border
        bg-background-elevated accent-primary-solid
        focus:ring-2 focus:ring-primary-solid"

# Radio
class: "h-5 w-5 border border-border
        bg-background-elevated accent-primary-solid
        focus:ring-2 focus:ring-primary-solid"
```

### Page Layout

```ruby
# Page container
class: "px-layout py-layout bg-background"

# Page title
class: "text-page-title leading-page-title font-page-title-weight text-foreground"

# Page description
class: "text-page-description leading-page-description text-muted-foreground"
```
