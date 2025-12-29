import { Controller } from "@hotwired/stimulus";
import { computePosition, flip, shift, offset, autoUpdate } from "@floating-ui/dom";

export default class extends Controller {
  static targets = ["menu", "search", "option", "empty", "trigger"];
  static values = {
    open: { type: Boolean, default: false },
    searchable: { type: Boolean, default: false },
    placement: { type: String, default: "bottom-end" },
    offset: { type: Number, default: 8 },
  };

  connect() {
    this.closeOnClickOutside = this.closeOnClickOutside.bind(this);
    this.handleKeydown = this.handleKeydown.bind(this);
    this.cleanup = null;
  }

  disconnect() {
    this.stopPositioning();
    document.removeEventListener("click", this.closeOnClickOutside);
    document.removeEventListener("keydown", this.handleKeydown);
  }

  toggle(event) {
    event.stopPropagation();
    this.openValue ? this.close() : this.open();
  }

  open() {
    this.openValue = true;
    this.menuTarget.classList.remove("hidden");

    document.addEventListener("click", this.closeOnClickOutside);
    document.addEventListener("keydown", this.handleKeydown);

    // Start auto-positioning with Floating UI
    this.startPositioning();

    if (this.searchableValue && this.hasSearchTarget) {
      this.searchTarget.value = "";
      this.filter();
      setTimeout(() => this.searchTarget.focus(), 0);
    }
  }

  startPositioning() {
    if (!this.hasTriggerTarget || !this.hasMenuTarget) return;

    // autoUpdate automatically handles scroll, resize, and DOM changes
    this.cleanup = autoUpdate(
      this.triggerTarget,
      this.menuTarget,
      () => this.updatePosition()
    );
  }

  async updatePosition() {
    if (!this.hasTriggerTarget || !this.hasMenuTarget) return;

    const { x, y } = await computePosition(this.triggerTarget, this.menuTarget, {
      placement: this.placementValue,
      middleware: [
        offset(this.offsetValue),
        flip({
          fallbackPlacements: ["top-end", "bottom-start", "top-start"],
        }),
        shift({ padding: 8 }),
      ],
    });

    Object.assign(this.menuTarget.style, {
      left: `${x}px`,
      top: `${y}px`,
    });
  }

  stopPositioning() {
    if (this.cleanup) {
      this.cleanup();
      this.cleanup = null;
    }
  }

  close() {
    this.openValue = false;
    this.menuTarget.classList.add("hidden");
    this.stopPositioning();
    document.removeEventListener("click", this.closeOnClickOutside);
    document.removeEventListener("keydown", this.handleKeydown);
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close();
    }
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }

  filter() {
    if (!this.hasSearchTarget || !this.hasOptionTarget) return;

    const query = this.searchTarget.value.toLowerCase().trim();
    let visibleCount = 0;

    this.optionTargets.forEach((option) => {
      const label = option.dataset.label?.toLowerCase() || option.textContent.toLowerCase();
      const matches = query === "" || label.includes(query);

      option.classList.toggle("hidden", !matches);
      if (matches) visibleCount++;
    });

    if (this.hasEmptyTarget) {
      this.emptyTarget.classList.toggle("hidden", visibleCount > 0);
    }
  }

  select(event) {
    const option = event.currentTarget;
    const value = option.dataset.value;
    const label = option.dataset.label || option.textContent.trim();

    console.log("Dropdown select clicked:", { value, label });
    this.dispatch("select", { detail: { value, label, event } });
    console.log("Event dispatched, defaultPrevented:", event.defaultPrevented);

    // Don't close if parent controller prevents default
    if (!event.defaultPrevented) {
      console.log("Closing dropdown");
      this.close();
    } else {
      console.log("Keeping dropdown open");
    }
  }
}
