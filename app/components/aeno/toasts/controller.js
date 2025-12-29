import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.observer = new MutationObserver(() => this.updateStack());
    this.observer.observe(this.element, { childList: true });
    this.updateStack();
  }

  disconnect() {
    this.observer.disconnect();
  }

  updateStack() {
    let offset = 0;
    this.element.querySelectorAll("[data-toast]").forEach((toast, i) => {
      toast.style.setProperty("--index", i);
      toast.style.setProperty("--offset", offset);
      offset += toast.offsetHeight + 14; // 14px = 0.875rem gap
    });
  }
}
