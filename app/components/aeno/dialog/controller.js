import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["background", "wrapper"];

  connect() {
    requestAnimationFrame(() => this.open());
    document.addEventListener("keydown", this.handleEscape);
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleEscape);
    this.restoreBodyScroll();
  }

  handleEscape = (e) => {
    if (e.key === "Escape") this.close();
  };

  open() {
    this.backgroundTarget.classList.remove("opacity-0", "pointer-events-none");
    this.backgroundTarget.classList.add("opacity-100", "pointer-events-auto");
    this.wrapperTarget.classList.remove("opacity-0", "scale-95");
    this.wrapperTarget.classList.add("opacity-100", "scale-100");
    document.body.classList.add("overflow-hidden");
  }

  close() {
    this.backgroundTarget.classList.remove("opacity-100", "pointer-events-auto");
    this.backgroundTarget.classList.add("opacity-0", "pointer-events-none");
    this.wrapperTarget.classList.remove("opacity-100", "scale-100");
    this.wrapperTarget.classList.add("opacity-0", "scale-95");

    setTimeout(() => {
      this.element.remove();
      this.restoreBodyScroll();
    }, 300);
  }

  restoreBodyScroll() {
    const openDialogs = document.querySelectorAll(
      '[data-aeno--dialog-target="background"].opacity-100',
    );
    if (openDialogs.length === 0) {
      document.body.classList.remove("overflow-hidden");
    }
  }
}
